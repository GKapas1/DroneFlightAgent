# spawn_drone.launch.py
import os
from shutil import which
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch.actions import (
    IncludeLaunchDescription,
    DeclareLaunchArgument,
    SetEnvironmentVariable,
    TimerAction,
    ExecuteProcess,
)
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.conditions import IfCondition, UnlessCondition
from launch.substitutions import LaunchConfiguration
from launch_ros.actions import Node

def generate_launch_description():
    # headless: "true" (server-only) or "false" (GUI)
    headless = LaunchConfiguration('headless')
    headless_arg = DeclareLaunchArgument(
        'headless', default_value='true',
        description='Run without GUI (true) or with GUI (false)'
    )

    pkg_path = get_package_share_directory('drone_sim')

    # Make models discoverable to Gazebo
    set_gz_path = SetEnvironmentVariable(
        name='GZ_SIM_RESOURCE_PATH',
        value=os.path.join(pkg_path, 'models')
    )

    world_file = os.path.join(pkg_path, 'worlds', 'empty.world')

    # Decide which CLI we have: 'gz' (preferred) or fallback to 'ign gazebo'
    has_gz = which('gz') is not None
    if has_gz:
        server_cmd = ['gz', 'sim', '-r', '-s', world_file, '--headless-rendering']
        gui_args  = f'-r {world_file}'
    else:
        # Fortress-era tools commonly still expose 'ign'
        server_cmd = ['ign', 'gazebo', '-r', '-s', world_file, '--headless-rendering']
        gui_args  = f'-r {world_file}'

    # HEADLESS: run server-only directly → no GUI process ever spawns
    gz_server_only = ExecuteProcess(
        cmd=server_cmd,
        output='screen',
        condition=IfCondition(headless)
    )

    # GUI path: use ros_gz_sim’s launcher (spawns client+server)
    gz_launch = PythonLaunchDescriptionSource(
        [os.path.join(get_package_share_directory('ros_gz_sim'),
                      'launch', 'gz_sim.launch.py')]
    )
    gz_with_gui = IncludeLaunchDescription(
        gz_launch,
        condition=UnlessCondition(headless),
        launch_arguments={
            'gui': 'true',
            'gz_args': gui_args
        }.items()
    )

    # Spawn the drone (delay to let server come up)
    spawn_entity = Node(
        package='ros_gz_sim',
        executable='create',
        arguments=[
            '-file', os.path.join(pkg_path, 'models', 'simple_drone', 'model.sdf'),
            '-name', 'simple_drone',
            '-x', '0.0', '-y', '0.0', '-z', '0.5'
        ],
        output='screen'
    )
    delayed_spawn = TimerAction(period=2.0, actions=[spawn_entity])

    # IMU bridge
    imu_bridge = Node(
        package='ros_gz_bridge',
        executable='parameter_bridge',
        arguments=['/drone/imu_data@sensor_msgs/msg/Imu@gz.msgs.IMU'],
        output='screen'
    )
    delayed_bridge = TimerAction(period=3.0, actions=[imu_bridge])

    return LaunchDescription([
        headless_arg,
        set_gz_path,
        gz_server_only,   # only active when headless:=true
        gz_with_gui,      # only active when headless:=false
        delayed_spawn,
        delayed_bridge,
    ])
