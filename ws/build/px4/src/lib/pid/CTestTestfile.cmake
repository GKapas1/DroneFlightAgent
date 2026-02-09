# CMake generated Testfile for 
# Source directory: /repo/ws/src/px4/src/lib/pid
# Build directory: /repo/ws/build/px4/src/lib/pid
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(unit-PID "/repo/ws/build/px4/unit-PID")
set_tests_properties(unit-PID PROPERTIES  WORKING_DIRECTORY "/repo/ws/build/px4" _BACKTRACE_TRIPLES "/repo/ws/src/px4/cmake/gtest/px4_add_gtest.cmake;71;add_test;/repo/ws/src/px4/src/lib/pid/CMakeLists.txt;40;px4_add_unit_gtest;/repo/ws/src/px4/src/lib/pid/CMakeLists.txt;0;")
