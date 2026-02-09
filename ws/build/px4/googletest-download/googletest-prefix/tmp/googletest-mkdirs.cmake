# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/repo/ws/build/px4/googletest-src"
  "/repo/ws/build/px4/googletest-build"
  "/repo/ws/build/px4/googletest-download/googletest-prefix"
  "/repo/ws/build/px4/googletest-download/googletest-prefix/tmp"
  "/repo/ws/build/px4/googletest-download/googletest-prefix/src/googletest-stamp"
  "/repo/ws/build/px4/googletest-download/googletest-prefix/src"
  "/repo/ws/build/px4/googletest-download/googletest-prefix/src/googletest-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/repo/ws/build/px4/googletest-download/googletest-prefix/src/googletest-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/repo/ws/build/px4/googletest-download/googletest-prefix/src/googletest-stamp${cfgdir}") # cfgdir has leading slash
endif()
