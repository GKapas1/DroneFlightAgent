# px4_gz_bringup.launch.py — Gazebo (gz) Garden + PX4 SITL bringup
# Supports headless & GUI. Lets you choose PX4 spawn (PX4_SIM_MODEL)
# or bind to an existing model (PX4_GZ_MODEL_NAME).

import os
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch.actions import (
    DeclareLaunchArgument,
    SetEnvironmentVariable,
    TimerAction,
    ExecuteProcess,
)
from launch.conditions import IfCondition, UnlessCondition
from launch.substitutions import LaunchConfiguration


def generate_launch_description():
    # -------------------------
    # Launch arguments
    # -------------------------
    headless = LaunchConfiguration('headless')
    px4 = LaunchConfiguration('px4')
    px4_sim_model = LaunchConfiguration('px4_sim_model')
    px4_gz_model_name = LaunchConfiguration('px4_gz_model_name')
    px4_sys_autostart = LaunchConfiguration('px4_sys_autostart')

    headless_arg = DeclareLaunchArgument(
        'headless', default_value='true',
        description='Run without GUI ("true") or with GUI ("false")'
    )
    px4_arg = DeclareLaunchArgument(
        'px4', default_value='true',
        description='Start PX4 SITL alongside Gazebo ("true" or "false")'
    )
    px4_sim_model_arg = DeclareLaunchArgument(
        'px4_sim_model', default_value='x500',
        description='PX4 will spawn this model (e.g., x500). Leave empty to skip spawning.'
    )
    px4_gz_model_name_arg = DeclareLaunchArgument(
        'px4_gz_model_name', default_value='',
        description='Existing model name in Gazebo to bind to (overrides spawn if set).'
    )
    
    px4_sys_autostart_arg = DeclareLaunchArgument(
    'px4_sys_autostart', default_value='4001',
    description='PX4 airframe autostart ID (e.g., 4001 for x500).'
    )

    # -------------------------
    # Paths
    # -------------------------
    pkg_path = get_package_share_directory('drone_sim')
    px4_root = os.environ.get('PX4_ROOT', '/repo/ws/src/px4')
    px4_gz_root = os.path.join(px4_root, 'Tools', 'simulation', 'gz')

    # world file (change if you have a different one)
    world_file = os.environ.get(
        'DRONE_SIM_WORLD',
        os.path.join(pkg_path, 'worlds', 'empty.world')
    )

    # -------------------------
    # Gazebo resources & headless safety
    # -------------------------
    set_gz_path = SetEnvironmentVariable(
        name='GZ_SIM_RESOURCE_PATH',
        value=":".join([
            os.path.join(pkg_path, 'models'),
            os.path.join(px4_gz_root, 'models'),  # ensure PX4 models resolve
            px4_gz_root
        ])
    )
    # headless container safety; can be overridden if you pass a GPU
    soft_gl = SetEnvironmentVariable(name='LIBGL_ALWAYS_SOFTWARE', value='1')
    disable_gui_flag = SetEnvironmentVariable(name='GZ_GUI', value='0')

    # -------------------------
    # Start Gazebo (gz) directly (no Ignition)
    # -------------------------
    gazebo_headless = ExecuteProcess(
        cmd=['gz', 'sim', '-r', '--headless-rendering', world_file],
        output='screen',
        condition=IfCondition(headless)
    )

    gazebo_gui = ExecuteProcess(
        cmd=['gz', 'sim', '-r', world_file],
        output='screen',
        condition=UnlessCondition(headless)
    )

    # -------------------------
    # PX4 SITL (gz/Garden bridge)
    # -------------------------
    px4_build = os.path.join(px4_root, 'build', 'px4_sitl_default')
    px4_bin = os.path.join(px4_build, 'bin', 'px4')
    rcs_rel = 'etc/init.d-posix/rcS'  # valid when cwd=px4_build

    px4_proc = ExecuteProcess(
        cmd=[px4_bin, '-d', '-s', rcs_rel],
        cwd=px4_build,
        output='screen',
        additional_env={
            'PX4_SYS_AUTOSTART': px4_sys_autostart,
            'PX4_SIM_MODEL': px4_sim_model,          # spawn path
            'PX4_GZ_MODEL_NAME': px4_gz_model_name,  # bind path (overrides spawn if set)
        },
        condition=IfCondition(px4)
    )

    # Give gz a moment to fully start so /world/*/create is ready
    delayed_px4 = TimerAction(period=6.0, actions=[px4_proc])

    return LaunchDescription([
        headless_arg,
        px4_arg,
        px4_sim_model_arg,
        px4_gz_model_name_arg,
        px4_sys_autostart_arg,
        set_gz_path,
        soft_gl,
        disable_gui_flag,
        gazebo_headless,
        gazebo_gui,
        delayed_px4,
    ])

