# CMake generated Testfile for 
# Source directory: /repo/ws/src/px4/src/lib/control_allocation/control_allocation
# Build directory: /repo/ws/build/px4/src/lib/control_allocation/control_allocation
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(unit-ControlAllocationPseudoInverse "/repo/ws/build/px4/unit-ControlAllocationPseudoInverse")
set_tests_properties(unit-ControlAllocationPseudoInverse PROPERTIES  WORKING_DIRECTORY "/repo/ws/build/px4" _BACKTRACE_TRIPLES "/repo/ws/src/px4/cmake/gtest/px4_add_gtest.cmake;71;add_test;/repo/ws/src/px4/src/lib/control_allocation/control_allocation/CMakeLists.txt;46;px4_add_unit_gtest;/repo/ws/src/px4/src/lib/control_allocation/control_allocation/CMakeLists.txt;0;")
add_test(functional-ControlAllocationSequentialDesaturation "/repo/ws/build/px4/functional-ControlAllocationSequentialDesaturation")
set_tests_properties(functional-ControlAllocationSequentialDesaturation PROPERTIES  _BACKTRACE_TRIPLES "/repo/ws/src/px4/cmake/gtest/px4_add_gtest.cmake;125;add_test;/repo/ws/src/px4/src/lib/control_allocation/control_allocation/CMakeLists.txt;47;px4_add_functional_gtest;/repo/ws/src/px4/src/lib/control_allocation/control_allocation/CMakeLists.txt;0;")
