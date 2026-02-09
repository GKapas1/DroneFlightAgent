# CMake generated Testfile for 
# Source directory: /repo/ws/src/px4/src/lib/slew_rate
# Build directory: /repo/ws/build/px4/src/lib/slew_rate
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(unit-SlewRate "/repo/ws/build/px4/unit-SlewRate")
set_tests_properties(unit-SlewRate PROPERTIES  WORKING_DIRECTORY "/repo/ws/build/px4" _BACKTRACE_TRIPLES "/repo/ws/src/px4/cmake/gtest/px4_add_gtest.cmake;71;add_test;/repo/ws/src/px4/src/lib/slew_rate/CMakeLists.txt;46;px4_add_unit_gtest;/repo/ws/src/px4/src/lib/slew_rate/CMakeLists.txt;0;")
add_test(unit-SlewRateYaw "/repo/ws/build/px4/unit-SlewRateYaw")
set_tests_properties(unit-SlewRateYaw PROPERTIES  WORKING_DIRECTORY "/repo/ws/build/px4" _BACKTRACE_TRIPLES "/repo/ws/src/px4/cmake/gtest/px4_add_gtest.cmake;71;add_test;/repo/ws/src/px4/src/lib/slew_rate/CMakeLists.txt;47;px4_add_unit_gtest;/repo/ws/src/px4/src/lib/slew_rate/CMakeLists.txt;0;")
