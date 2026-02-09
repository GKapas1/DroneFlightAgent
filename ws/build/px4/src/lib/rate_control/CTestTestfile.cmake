# CMake generated Testfile for 
# Source directory: /repo/ws/src/px4/src/lib/rate_control
# Build directory: /repo/ws/build/px4/src/lib/rate_control
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(unit-rate_control_test "/repo/ws/build/px4/unit-rate_control_test")
set_tests_properties(unit-rate_control_test PROPERTIES  WORKING_DIRECTORY "/repo/ws/build/px4" _BACKTRACE_TRIPLES "/repo/ws/src/px4/cmake/gtest/px4_add_gtest.cmake;71;add_test;/repo/ws/src/px4/src/lib/rate_control/CMakeLists.txt;42;px4_add_unit_gtest;/repo/ws/src/px4/src/lib/rate_control/CMakeLists.txt;0;")
