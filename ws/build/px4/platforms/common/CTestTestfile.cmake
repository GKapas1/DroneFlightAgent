# CMake generated Testfile for 
# Source directory: /repo/ws/src/px4/platforms/common
# Build directory: /repo/ws/build/px4/platforms/common
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(unit-board_identity_test "/repo/ws/build/px4/unit-board_identity_test")
set_tests_properties(unit-board_identity_test PROPERTIES  WORKING_DIRECTORY "/repo/ws/build/px4" _BACKTRACE_TRIPLES "/repo/ws/src/px4/cmake/gtest/px4_add_gtest.cmake;71;add_test;/repo/ws/src/px4/platforms/common/CMakeLists.txt;73;px4_add_unit_gtest;/repo/ws/src/px4/platforms/common/CMakeLists.txt;0;")
subdirs("uORB")
subdirs("px4_work_queue")
subdirs("work_queue")
