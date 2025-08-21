# CMake generated Testfile for 
# Source directory: /repo/ws/src/px4/src/lib/motion_planning
# Build directory: /repo/ws/build/px4/src/lib/motion_planning
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(unit-VelocitySmoothing "/repo/ws/build/px4/unit-VelocitySmoothing")
set_tests_properties(unit-VelocitySmoothing PROPERTIES  WORKING_DIRECTORY "/repo/ws/build/px4" _BACKTRACE_TRIPLES "/repo/ws/src/px4/cmake/gtest/px4_add_gtest.cmake;71;add_test;/repo/ws/src/px4/src/lib/motion_planning/CMakeLists.txt;43;px4_add_unit_gtest;/repo/ws/src/px4/src/lib/motion_planning/CMakeLists.txt;0;")
add_test(unit-PositionSmoothing "/repo/ws/build/px4/unit-PositionSmoothing")
set_tests_properties(unit-PositionSmoothing PROPERTIES  WORKING_DIRECTORY "/repo/ws/build/px4" _BACKTRACE_TRIPLES "/repo/ws/src/px4/cmake/gtest/px4_add_gtest.cmake;71;add_test;/repo/ws/src/px4/src/lib/motion_planning/CMakeLists.txt;44;px4_add_unit_gtest;/repo/ws/src/px4/src/lib/motion_planning/CMakeLists.txt;0;")
