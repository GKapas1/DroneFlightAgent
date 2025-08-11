import os
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch.actions import (
    IncludeLaunchDescription,
    DeclareLaunchArgument,
    SetEnvironmentVariable,
    TimerAction,
)
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.conditions import IfCondition, UnlessCondition
from launch.substitutions import LaunchConfiguration
from launch_ros.actions import Node

def generate_launch_description():
    # Arg: headless (true/false)
    headless = LaunchConfiguration('headless')
    headless_arg = DeclareLaunchArgument(
        'headless', default_value='true',
        description='Run Gazebo without GUI (true) or with GUI (false)'
    )

    pkg_path = get_package_share_directory('drone_sim')

    # Make models discoverable by Gazebo (use a launch action, not os.environ)
    set_gz_path = SetEnvironmentVariable(
        name='GZ_SIM_RESOURCE_PATH',
        value=os.path.join(pkg_path, 'models')
    )

    world_file = os.path.join(pkg_path, 'worlds', 'empty.world')

    gz_launch = PythonLaunchDescriptionSource(
        [os.path.join(get_package_share_directory('ros_gz_sim'),
                      'launch', 'gz_sim.launch.py')]
    )

    # Headless vs GUI variants
    gazebo_headless = IncludeLaunchDescription(
        gz_launch,
        launch_arguments={'gz_args': f'-r {world_file} --headless-rendering'}.items(),
        condition=IfCondition(headless)
    )

    gazebo_gui = IncludeLaunchDescription(
        gz_launch,
        launch_arguments={'gz_args': f'-r {world_file}'}.items(),
        condition=UnlessCondition(headless)
    )

    # Spawn the drone (delay to let the sim start)
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

    # Bridge IMU
    imu_bridge = Node(
        package='ros_gz_bridge',
        executable='parameter_bridge',
        arguments=['/drone/imu_data@sensor_msgs/msg/Imu[gz.msgs.IMU]'],
        output='screen'
    )
    delayed_bridge = TimerAction(period=3.0, actions=[imu_bridge])

    return LaunchDescription([
        headless_arg,
        set_gz_path,
        gazebo_headless,
        gazebo_gui,
        delayed_spawn,
        delayed_bridge,
    ])
