cmake_minimum_required(VERSION 3.10)
project(drone_sim)

find_package(ament_cmake REQUIRED)
find_package(ros_gz_sim REQUIRED)
# target_link_libraries(your_target PRIVATE ros_gz_sim::ros_gz_sim)


# Install models and worlds
install(DIRECTORY models worlds
  DESTINATION share/${PROJECT_NAME})

# Install launch files
install(DIRECTORY launch
  DESTINATION share/${PROJECT_NAME})

ament_package()

