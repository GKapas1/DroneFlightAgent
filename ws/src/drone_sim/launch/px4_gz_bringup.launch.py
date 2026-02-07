import os
from shutil import which

from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch.actions import (
    DeclareLaunchArgument,
    ExecuteProcess,
    RegisterEventHandler,
    SetEnvironmentVariable,
)
from launch.conditions import IfCondition, UnlessCondition
from launch.event_handlers import OnProcessExit
from launch.substitutions import LaunchConfiguration
from launch_ros.actions import Node


def generate_launch_description():
    pkg_path = get_package_share_directory("drone_sim")

    px4_root = os.environ.get("PX4_ROOT", "/repo/ws/src/px4")
    px4_gz_root = os.path.join(px4_root, "Tools", "simulation", "gz")

    headless = LaunchConfiguration("headless")
    px4 = LaunchConfiguration("px4")
    px4_sim_model = LaunchConfiguration("px4_sim_model")
    px4_gz_model_name = LaunchConfiguration("px4_gz_model_name")
    px4_sys_autostart = LaunchConfiguration("px4_sys_autostart")
    world_file = LaunchConfiguration("world_file")
    world_name = LaunchConfiguration("world_name")
    verbose = LaunchConfiguration("verbose")
    reset = LaunchConfiguration("reset")

    args = [
        DeclareLaunchArgument(
            "world_file",
            default_value=os.path.join(pkg_path, "worlds", "empty.world"),
        ),
        DeclareLaunchArgument("world_name", default_value="empty"),
        DeclareLaunchArgument("headless", default_value="true"),
        DeclareLaunchArgument("px4", default_value="true"),
        DeclareLaunchArgument("px4_sim_model", default_value=""),
        DeclareLaunchArgument("px4_gz_model_name", default_value="x500_custom"),
        DeclareLaunchArgument("px4_sys_autostart", default_value="4001"),
        DeclareLaunchArgument("verbose", default_value="4"),
        DeclareLaunchArgument("reset", default_value="true"),
    ]

    # IMPORTANT: only resource paths + rendering hints. No partition/ports pinning.
    env = [
        SetEnvironmentVariable(
            name="GZ_SIM_RESOURCE_PATH",
            value=":".join(
                [
                    os.path.join(pkg_path, "models"),
                    os.path.join(px4_gz_root, "models"),
                    px4_gz_root,
                ]
            ),
        ),
        SetEnvironmentVariable(name="GZ_RENDER_ENGINE", value="ogre2"),
        SetEnvironmentVariable(name="GZ_GUI", value="0", condition=IfCondition(headless)),
        SetEnvironmentVariable(name="QT_QPA_PLATFORM", value="offscreen", condition=IfCondition(headless)),
        SetEnvironmentVariable(name="LIBGL_ALWAYS_SOFTWARE", value="1", condition=IfCondition(headless)),
        SetEnvironmentVariable(name="GZ_GUI", value="1", condition=UnlessCondition(headless)),
        SetEnvironmentVariable(name="QT_QPA_PLATFORM", value="xcb", condition=UnlessCondition(headless)),
    ]

    reset_proc = ExecuteProcess(
        cmd=[
            "bash",
            "-lc",
            r"""
            set -euo pipefail
            if [ "${RESET:-true}" != "true" ]; then
            echo "[reset] Skipped (reset:=false)."
            exit 0
            fi

            echo "[reset] Checking for leftover processes…"

            # Kill processes matching a pattern, but NEVER kill this script ($$) or its parent ($PPID).
            kill_by_pat() {
            pat="$1"
            name="$2"

            # Get PIDs that match full cmdline (-f). Use || true so no-match isn't fatal.
            pids="$(pgrep -f "$pat" 2>/dev/null || true)"
            pids="$(echo "$pids" | tr ' ' '\n' | grep -E '^[0-9]+$' || true)"

            # Filter out this bash and its parent so we don't self-terminate.
            pids="$(echo "$pids" | grep -v -E "^($$|$PPID)$" || true)"

            if [ -z "${pids}" ]; then
                return 0
            fi

            echo "[reset] Found running ${name} PIDs: ${pids}"

            # Try TERM first
            for pid in $pids; do
                kill -TERM "$pid" >/dev/null 2>&1 || true
            done

            # Wait up to ~2s for them to exit
            for _ in 1 2 3 4 5 6 7 8 9 10; do
                still=""
                for pid in $pids; do
                if kill -0 "$pid" >/dev/null 2>&1; then
                    still="$still $pid"
                fi
                done
                if [ -z "${still// }" ]; then
                break
                fi
                sleep 0.2
            done

            # KILL anything still alive
            still=""
            for pid in $pids; do
                if kill -0 "$pid" >/dev/null 2>&1; then
                still="$still $pid"
                fi
            done
            if [ -n "${still// }" ]; then
                echo "[reset] Force-killing ${name} PIDs:${still}"
                for pid in $still; do
                kill -KILL "$pid" >/dev/null 2>&1 || true
                done
            fi
            }

            # Gazebo + PX4 + bridges
            # NOTE: even if the *pattern string* appears in this script, we won't kill $$/$PPID anymore.
            kill_by_pat '[g]z[[:space:]]+sim([[:space:]]|$)' "Gazebo (gz sim)"
            kill_by_pat '[g]z-sim'                         "Gazebo (gz-sim*)"
            kill_by_pat '[g]zserver'                       "Gazebo (gzserver)"
            kill_by_pat '[g]zclient'                       "Gazebo (gzclient)"

            kill_by_pat 'px4_sitl_default/bin/p[x]4'       "PX4"

            kill_by_pat '(^|/)(g[z]_bridge)([[:space:]]|$)'     "gz_bridge"
            kill_by_pat '(^|/)(ros_[g]z_bridge)([[:space:]]|$)' "ros_gz_bridge"

            echo "[reset] OK."
            """,
        ],
        output="screen",
        additional_env={"RESET": reset},
    )

    server_config = os.path.join(px4_gz_root, "server.config")
    prime_cfg = ExecuteProcess(
        cmd=[
            "bash",
            "-lc",
            f'mkdir -p ~/.gz/sim/8 && cp -f "{server_config}" ~/.gz/sim/8/server.config && '
            'echo "[gz] primed ~/.gz/sim/8/server.config"',
        ],
        output="screen",
    )

    sim_cmd = ["gz", "sim"] if which("gz") else ["ign", "gazebo"]

    gz_headless = ExecuteProcess(
        cmd=sim_cmd + ["-r", "-s", "--headless-rendering", "-v", verbose, world_file],
        output="screen",
        condition=IfCondition(headless),
    )
    gz_gui = ExecuteProcess(
        cmd=sim_cmd + ["-r", "-v", verbose, world_file],
        output="screen",
        condition=UnlessCondition(headless),
    )

    unpause = ExecuteProcess(
        cmd=[
            "bash",
            "-lc",
            r"""
            for i in $(seq 1 200); do
              gz service -s /world/${WORLD_NAME}/control \
                --reqtype gz.msgs.WorldControl --reptype gz.msgs.Boolean \
                --req 'pause: false' >/dev/null 2>&1 && break
              sleep 0.1
            done
            echo "[unpause] Requested pause:false on /world/${WORLD_NAME}/control"
            """,
        ],
        output="screen",
        additional_env={"WORLD_NAME": world_name},
    )

    wait_sensors = ExecuteProcess(
        cmd=[
            "bash",
            "-lc",
            r"""
            set -e
            IMU="/world/${WORLD_NAME}/model/${MODEL}/link/base_link/sensor/imu_sensor/imu"
            BARO="/world/${WORLD_NAME}/model/${MODEL}/link/base_link/sensor/air_pressure_sensor/air_pressure"

            echo "[wait] Waiting for topics to exist…"
            until gz topic -i -t "$IMU"  >/dev/null 2>&1; do sleep 0.1; done
            until gz topic -i -t "$BARO" >/dev/null 2>&1; do sleep 0.1; done

            echo "[wait] Waiting for IMU x2…"
            gz topic -e -t "$IMU" -n 1 >/dev/null 2>&1
            gz topic -e -t "$IMU" -n 1 >/dev/null 2>&1

            echo "[wait] Waiting for BARO x2…"
            gz topic -e -t "$BARO" -n 1 >/dev/null 2>&1
            gz topic -e -t "$BARO" -n 1 >/dev/null 2>&1

            echo "[wait] Sensor streams verified."
            """,
        ],
        output="screen",
        additional_env={"WORLD_NAME": world_name, "MODEL": px4_gz_model_name},
    )

    px4_build = os.path.join(px4_root, "build", "px4_sitl_default")
    px4_bin = os.path.join(px4_build, "bin", "px4")

    px4_proc = ExecuteProcess(
        cmd=[px4_bin, "-d", "-s", "etc/init.d-posix/rcS"],
        cwd=px4_build,
        output="screen",
        additional_env={
            "PX4_SYS_AUTOSTART": px4_sys_autostart,
            "PX4_SIM_MODEL": px4_sim_model,
            "PX4_GZ_MODEL_NAME": px4_gz_model_name,
        },
        condition=IfCondition(px4),
    )

    # ROS bridges (not PX4 sensors, but keep correct paths)
    bridges = Node(
        package="ros_gz_bridge",
        executable="parameter_bridge",
        arguments=[
            "/world/empty/model/x500_custom/link/base_link/sensor/imu_sensor/imu@sensor_msgs/msg/Imu[gz.msgs.IMU",
            "/world/empty/model/x500_custom/link/base_link/sensor/air_pressure_sensor/air_pressure@sensor_msgs/msg/FluidPressure[gz.msgs.FluidPressure",
            "/world/empty/model/x500_custom/link/base_link/sensor/magnetometer_sensor/magnetometer@sensor_msgs/msg/MagneticField[gz.msgs.Magnetometer",
            "/world/empty/model/x500_custom/link/base_link/sensor/gps/navsat@sensor_msgs/msg/NavSatFix[gz.msgs.NavSat",
            "/clock@rosgraph_msgs/msg/Clock[gz.msgs.Clock",
        ],
        output="screen",
    )

    img_bridge = Node(
        package="ros_gz_image",
        executable="image_bridge",
        arguments=["/x500_custom/camera/image"],
        output="screen",
    )

    after_reset = RegisterEventHandler(OnProcessExit(target_action=reset_proc, on_exit=[prime_cfg]))
    after_prime = RegisterEventHandler(OnProcessExit(target_action=prime_cfg, on_exit=[gz_headless, gz_gui, unpause]))
    after_unpause = RegisterEventHandler(OnProcessExit(target_action=unpause, on_exit=[wait_sensors]))
    after_wait = RegisterEventHandler(OnProcessExit(target_action=wait_sensors, on_exit=[px4_proc, bridges, img_bridge]))

    return LaunchDescription(args + env + [reset_proc, after_reset, after_prime, after_unpause, after_wait])
