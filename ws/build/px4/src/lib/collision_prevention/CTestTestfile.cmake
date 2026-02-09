# CMake generated Testfile for 
# Source directory: /repo/ws/src/px4/src/lib/collision_prevention
# Build directory: /repo/ws/build/px4/src/lib/collision_prevention
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(functional-CollisionPrevention "/repo/ws/build/px4/functional-CollisionPrevention")
set_tests_properties(functional-CollisionPrevention PROPERTIES  _BACKTRACE_TRIPLES "/repo/ws/src/px4/cmake/gtest/px4_add_gtest.cmake;125;add_test;/repo/ws/src/px4/src/lib/collision_prevention/CMakeLists.txt;42;px4_add_functional_gtest;/repo/ws/src/px4/src/lib/collision_prevention/CMakeLists.txt;0;")
add_test(unit-ObstacleMath "/repo/ws/build/px4/unit-ObstacleMath")
set_tests_properties(unit-ObstacleMath PROPERTIES  WORKING_DIRECTORY "/repo/ws/build/px4" _BACKTRACE_TRIPLES "/repo/ws/src/px4/cmake/gtest/px4_add_gtest.cmake;71;add_test;/repo/ws/src/px4/src/lib/collision_prevention/CMakeLists.txt;43;px4_add_unit_gtest;/repo/ws/src/px4/src/lib/collision_prevention/CMakeLists.txt;0;")
