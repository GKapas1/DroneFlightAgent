# generated from
# ament_cmake_core/cmake/symlink_install/ament_cmake_symlink_install.cmake.in

# create empty symlink install manifest before starting install step
file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/symlink_install_manifest.txt")

#
# Reimplement CMake install(DIRECTORY) command to use symlinks instead of
# copying resources.
#
# :param cmake_current_source_dir: The CMAKE_CURRENT_SOURCE_DIR when install
#   was invoked
# :type cmake_current_source_dir: string
# :param ARGN: the same arguments as the CMake install command.
# :type ARGN: various
#
function(ament_cmake_symlink_install_directory cmake_current_source_dir)
  cmake_parse_arguments(ARG "OPTIONAL" "DESTINATION" "DIRECTORY;PATTERN;PATTERN_EXCLUDE" ${ARGN})
  if(ARG_UNPARSED_ARGUMENTS)
    message(FATAL_ERROR "ament_cmake_symlink_install_directory() called with "
      "unused/unsupported arguments: ${ARG_UNPARSED_ARGUMENTS}")
  endif()

  # make destination absolute path and ensure that it exists
  if(NOT IS_ABSOLUTE "${ARG_DESTINATION}")
    set(ARG_DESTINATION "/repo/ws/install/${ARG_DESTINATION}")
  endif()
  if(NOT EXISTS "${ARG_DESTINATION}")
    file(MAKE_DIRECTORY "${ARG_DESTINATION}")
  endif()

  # default pattern to include
  if(NOT ARG_PATTERN)
    set(ARG_PATTERN "*")
  endif()

  # iterate over directories
  foreach(dir ${ARG_DIRECTORY})
    # make dir an absolute path
    if(NOT IS_ABSOLUTE "${dir}")
      set(dir "${cmake_current_source_dir}/${dir}")
    endif()

    if(EXISTS "${dir}")
      # if directory has no trailing slash
      # append folder name to destination
      set(destination "${ARG_DESTINATION}")
      string(LENGTH "${dir}" length)
      math(EXPR offset "${length} - 1")
      string(SUBSTRING "${dir}" ${offset} 1 dir_last_char)
      if(NOT dir_last_char STREQUAL "/")
        get_filename_component(destination_name "${dir}" NAME)
        set(destination "${destination}/${destination_name}")
      else()
        # remove trailing slash
        string(SUBSTRING "${dir}" 0 ${offset} dir)
      endif()

      # glob recursive files
      set(relative_files "")
      foreach(pattern ${ARG_PATTERN})
        file(
          GLOB_RECURSE
          include_files
          RELATIVE "${dir}"
          "${dir}/${pattern}"
        )
        if(NOT include_files STREQUAL "")
          list(APPEND relative_files ${include_files})
        endif()
      endforeach()
      foreach(pattern ${ARG_PATTERN_EXCLUDE})
        file(
          GLOB_RECURSE
          exclude_files
          RELATIVE "${dir}"
          "${dir}/${pattern}"
        )
        if(NOT exclude_files STREQUAL "")
          list(REMOVE_ITEM relative_files ${exclude_files})
        endif()
      endforeach()
      list(SORT relative_files)

      foreach(relative_file ${relative_files})
        set(absolute_file "${dir}/${relative_file}")
        # determine link name for file including destination path
        set(symlink "${destination}/${relative_file}")

        # ensure that destination exists
        get_filename_component(symlink_dir "${symlink}" PATH)
        if(NOT EXISTS "${symlink_dir}")
          file(MAKE_DIRECTORY "${symlink_dir}")
        endif()

        _ament_cmake_symlink_install_create_symlink("${absolute_file}" "${symlink}")
      endforeach()
    else()
      if(NOT ARG_OPTIONAL)
        message(FATAL_ERROR
          "ament_cmake_symlink_install_directory() can't find '${dir}'")
      endif()
    endif()
  endforeach()
endfunction()

#
# Reimplement CMake install(FILES) command to use symlinks instead of copying
# resources.
#
# :param cmake_current_source_dir: The CMAKE_CURRENT_SOURCE_DIR when install
#   was invoked
# :type cmake_current_source_dir: string
# :param ARGN: the same arguments as the CMake install command.
# :type ARGN: various
#
function(ament_cmake_symlink_install_files cmake_current_source_dir)
  cmake_parse_arguments(ARG "OPTIONAL" "DESTINATION;RENAME" "FILES" ${ARGN})
  if(ARG_UNPARSED_ARGUMENTS)
    message(FATAL_ERROR "ament_cmake_symlink_install_files() called with "
      "unused/unsupported arguments: ${ARG_UNPARSED_ARGUMENTS}")
  endif()

  # make destination an absolute path and ensure that it exists
  if(NOT IS_ABSOLUTE "${ARG_DESTINATION}")
    set(ARG_DESTINATION "/repo/ws/install/${ARG_DESTINATION}")
  endif()
  if(NOT EXISTS "${ARG_DESTINATION}")
    file(MAKE_DIRECTORY "${ARG_DESTINATION}")
  endif()

  if(ARG_RENAME)
    list(LENGTH ARG_FILES file_count)
    if(NOT file_count EQUAL 1)
    message(FATAL_ERROR "ament_cmake_symlink_install_files() called with "
      "RENAME argument but not with a single file")
    endif()
  endif()

  # iterate over files
  foreach(file ${ARG_FILES})
    # make file an absolute path
    if(NOT IS_ABSOLUTE "${file}")
      set(file "${cmake_current_source_dir}/${file}")
    endif()

    if(EXISTS "${file}")
      # determine link name for file including destination path
      get_filename_component(filename "${file}" NAME)
      if(NOT ARG_RENAME)
        set(symlink "${ARG_DESTINATION}/${filename}")
      else()
        set(symlink "${ARG_DESTINATION}/${ARG_RENAME}")
      endif()
      _ament_cmake_symlink_install_create_symlink("${file}" "${symlink}")
    else()
      if(NOT ARG_OPTIONAL)
        message(FATAL_ERROR
          "ament_cmake_symlink_install_files() can't find '${file}'")
      endif()
    endif()
  endforeach()
endfunction()

#
# Reimplement CMake install(PROGRAMS) command to use symlinks instead of copying
# resources.
#
# :param cmake_current_source_dir: The CMAKE_CURRENT_SOURCE_DIR when install
#   was invoked
# :type cmake_current_source_dir: string
# :param ARGN: the same arguments as the CMake install command.
# :type ARGN: various
#
function(ament_cmake_symlink_install_programs cmake_current_source_dir)
  cmake_parse_arguments(ARG "OPTIONAL" "DESTINATION" "PROGRAMS" ${ARGN})
  if(ARG_UNPARSED_ARGUMENTS)
    message(FATAL_ERROR "ament_cmake_symlink_install_programs() called with "
      "unused/unsupported arguments: ${ARG_UNPARSED_ARGUMENTS}")
  endif()

  # make destination an absolute path and ensure that it exists
  if(NOT IS_ABSOLUTE "${ARG_DESTINATION}")
    set(ARG_DESTINATION "/repo/ws/install/${ARG_DESTINATION}")
  endif()
  if(NOT EXISTS "${ARG_DESTINATION}")
    file(MAKE_DIRECTORY "${ARG_DESTINATION}")
  endif()

  # iterate over programs
  foreach(file ${ARG_PROGRAMS})
    # make file an absolute path
    if(NOT IS_ABSOLUTE "${file}")
      set(file "${cmake_current_source_dir}/${file}")
    endif()

    if(EXISTS "${file}")
      # determine link name for file including destination path
      get_filename_component(filename "${file}" NAME)
      set(symlink "${ARG_DESTINATION}/${filename}")
      _ament_cmake_symlink_install_create_symlink("${file}" "${symlink}")
    else()
      if(NOT ARG_OPTIONAL)
        message(FATAL_ERROR
          "ament_cmake_symlink_install_programs() can't find '${file}'")
      endif()
    endif()
  endforeach()
endfunction()

#
# Reimplement CMake install(TARGETS) command to use symlinks instead of copying
# resources.
#
# :param TARGET_FILES: the absolute files, replacing the name of targets passed
#   in as TARGETS
# :type TARGET_FILES: list of files
# :param ARGN: the same arguments as the CMake install command except that
#   keywords identifying the kind of type and the DESTINATION keyword must be
#   joined with an underscore, e.g. ARCHIVE_DESTINATION.
# :type ARGN: various
#
function(ament_cmake_symlink_install_targets)
  cmake_parse_arguments(ARG "OPTIONAL" "ARCHIVE_DESTINATION;DESTINATION;LIBRARY_DESTINATION;RUNTIME_DESTINATION"
    "TARGETS;TARGET_FILES" ${ARGN})
  if(ARG_UNPARSED_ARGUMENTS)
    message(FATAL_ERROR "ament_cmake_symlink_install_targets() called with "
      "unused/unsupported arguments: ${ARG_UNPARSED_ARGUMENTS}")
  endif()

  # iterate over target files
  foreach(file ${ARG_TARGET_FILES})
    if(NOT IS_ABSOLUTE "${file}")
      message(FATAL_ERROR "ament_cmake_symlink_install_targets() target file "
        "'${file}' must be an absolute path")
    endif()

    # determine destination of file based on extension
    set(destination "")
    get_filename_component(fileext "${file}" EXT)
    if(fileext STREQUAL ".a" OR fileext STREQUAL ".lib")
      set(destination "${ARG_ARCHIVE_DESTINATION}")
    elseif(fileext STREQUAL ".dylib" OR fileext MATCHES "\\.so(\\.[0-9]+)?(\\.[0-9]+)?(\\.[0-9]+)?$")
      set(destination "${ARG_LIBRARY_DESTINATION}")
    elseif(fileext STREQUAL "" OR fileext STREQUAL ".dll" OR fileext STREQUAL ".exe")
      set(destination "${ARG_RUNTIME_DESTINATION}")
    endif()
    if(destination STREQUAL "")
      set(destination "${ARG_DESTINATION}")
    endif()

    # make destination an absolute path and ensure that it exists
    if(NOT IS_ABSOLUTE "${destination}")
      set(destination "/repo/ws/install/${destination}")
    endif()
    if(NOT EXISTS "${destination}")
      file(MAKE_DIRECTORY "${destination}")
    endif()

    if(EXISTS "${file}")
      # determine link name for file including destination path
      get_filename_component(filename "${file}" NAME)
      set(symlink "${destination}/${filename}")
      _ament_cmake_symlink_install_create_symlink("${file}" "${symlink}")
    else()
      if(NOT ARG_OPTIONAL)
        message(FATAL_ERROR
          "ament_cmake_symlink_install_targets() can't find '${file}'")
      endif()
    endif()
  endforeach()
endfunction()

function(_ament_cmake_symlink_install_create_symlink absolute_file symlink)
  # register symlink for being removed during install step
  file(APPEND "${CMAKE_CURRENT_BINARY_DIR}/symlink_install_manifest.txt"
    "${symlink}\n")

  # avoid any work if correct symlink is already in place
  if(EXISTS "${symlink}" AND IS_SYMLINK "${symlink}")
    get_filename_component(destination "${symlink}" REALPATH)
    get_filename_component(real_absolute_file "${absolute_file}" REALPATH)
    if(destination STREQUAL real_absolute_file)
      message(STATUS "Up-to-date symlink: ${symlink}")
      return()
    endif()
  endif()

  message(STATUS "Symlinking: ${symlink}")
  if(EXISTS "${symlink}" OR IS_SYMLINK "${symlink}")
    file(REMOVE "${symlink}")
  endif()

  execute_process(
    COMMAND "/usr/bin/cmake" "-E" "create_symlink"
      "${absolute_file}"
      "${symlink}"
  )
  # the CMake command does not provide a return code so check manually
  if(NOT EXISTS "${symlink}" OR NOT IS_SYMLINK "${symlink}")
    get_filename_component(destination "${symlink}" REALPATH)
    message(FATAL_ERROR
      "Could not create symlink '${symlink}' pointing to '${absolute_file}'")
  endif()
endfunction()

# end of template

message(STATUS "Execute custom install script")

# begin of custom install code

# install(FILES "/repo/ws/build/px4/googletest-build/googletest/generated/GTestConfigVersion.cmake" "/repo/ws/build/px4/googletest-build/googletest/generated/GTestConfig.cmake" "DESTINATION" "lib/cmake/GTest")
ament_cmake_symlink_install_files("/repo/ws/build/px4/googletest-src/googletest" FILES "/repo/ws/build/px4/googletest-build/googletest/generated/GTestConfigVersion.cmake" "/repo/ws/build/px4/googletest-build/googletest/generated/GTestConfig.cmake" "DESTINATION" "lib/cmake/GTest")

# install(DIRECTORY "/repo/ws/build/px4/googletest-src/googletest/include/" "DESTINATION" "include")
ament_cmake_symlink_install_directory("/repo/ws/build/px4/googletest-src/googletest" DIRECTORY "/repo/ws/build/px4/googletest-src/googletest/include/" "DESTINATION" "include")

# install(FILES "/repo/ws/build/px4/googletest-build/googletest/generated/gtest.pc" "DESTINATION" "lib/pkgconfig")
ament_cmake_symlink_install_files("/repo/ws/build/px4/googletest-src/googletest" FILES "/repo/ws/build/px4/googletest-build/googletest/generated/gtest.pc" "DESTINATION" "lib/pkgconfig")

# install(FILES "/repo/ws/build/px4/googletest-build/googletest/generated/gtest_main.pc" "DESTINATION" "lib/pkgconfig")
ament_cmake_symlink_install_files("/repo/ws/build/px4/googletest-src/googletest" FILES "/repo/ws/build/px4/googletest-build/googletest/generated/gtest_main.pc" "DESTINATION" "lib/pkgconfig")

# install(DIRECTORY "/repo/ws/build/px4/googletest-src/googlemock/include/" "DESTINATION" "include")
ament_cmake_symlink_install_directory("/repo/ws/build/px4/googletest-src/googlemock" DIRECTORY "/repo/ws/build/px4/googletest-src/googlemock/include/" "DESTINATION" "include")

# install(FILES "/repo/ws/build/px4/googletest-build/googletest/generated/gmock.pc" "DESTINATION" "lib/pkgconfig")
ament_cmake_symlink_install_files("/repo/ws/build/px4/googletest-src/googlemock" FILES "/repo/ws/build/px4/googletest-build/googletest/generated/gmock.pc" "DESTINATION" "lib/pkgconfig")

# install(FILES "/repo/ws/build/px4/googletest-build/googletest/generated/gmock_main.pc" "DESTINATION" "lib/pkgconfig")
ament_cmake_symlink_install_files("/repo/ws/build/px4/googletest-src/googlemock" FILES "/repo/ws/build/px4/googletest-build/googletest/generated/gmock_main.pc" "DESTINATION" "lib/pkgconfig")

# install(FILES "/repo/ws/build/px4/ament_cmake_index/share/ament_index/resource_index/rosidl_interfaces/px4" "DESTINATION" "share/ament_index/resource_index/rosidl_interfaces")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/ament_cmake_index/share/ament_index/resource_index/rosidl_interfaces/px4" "DESTINATION" "share/ament_index/resource_index/rosidl_interfaces")

# install(DIRECTORY "/repo/ws/build/px4/platforms/ros2/rosidl_generator_c/px4/" "DESTINATION" "include/px4/px4" "PATTERN" "*.h")
ament_cmake_symlink_install_directory("/repo/ws/src/px4/platforms/ros2" DIRECTORY "/repo/ws/build/px4/platforms/ros2/rosidl_generator_c/px4/" "DESTINATION" "include/px4/px4" "PATTERN" "*.h")

# install(FILES "/opt/ros/humble/lib/python3.10/site-packages/ament_package/template/environment_hook/library_path.sh" "DESTINATION" "share/px4/environment")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/opt/ros/humble/lib/python3.10/site-packages/ament_package/template/environment_hook/library_path.sh" "DESTINATION" "share/px4/environment")

# install(FILES "/repo/ws/build/px4/ament_cmake_environment_hooks/library_path.dsv" "DESTINATION" "share/px4/environment")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/ament_cmake_environment_hooks/library_path.dsv" "DESTINATION" "share/px4/environment")

# install(DIRECTORY "/repo/ws/build/px4/platforms/ros2/rosidl_typesupport_fastrtps_c/px4/" "DESTINATION" "include/px4/px4" "PATTERN_EXCLUDE" "*.cpp")
ament_cmake_symlink_install_directory("/repo/ws/src/px4/platforms/ros2" DIRECTORY "/repo/ws/build/px4/platforms/ros2/rosidl_typesupport_fastrtps_c/px4/" "DESTINATION" "include/px4/px4" "PATTERN_EXCLUDE" "*.cpp")

# install(DIRECTORY "/repo/ws/build/px4/platforms/ros2/rosidl_generator_cpp/px4/" "DESTINATION" "include/px4/px4" "PATTERN" "*.hpp")
ament_cmake_symlink_install_directory("/repo/ws/src/px4/platforms/ros2" DIRECTORY "/repo/ws/build/px4/platforms/ros2/rosidl_generator_cpp/px4/" "DESTINATION" "include/px4/px4" "PATTERN" "*.hpp")

# install(DIRECTORY "/repo/ws/build/px4/platforms/ros2/rosidl_typesupport_fastrtps_cpp/px4/" "DESTINATION" "include/px4/px4" "PATTERN_EXCLUDE" "*.cpp")
ament_cmake_symlink_install_directory("/repo/ws/src/px4/platforms/ros2" DIRECTORY "/repo/ws/build/px4/platforms/ros2/rosidl_typesupport_fastrtps_cpp/px4/" "DESTINATION" "include/px4/px4" "PATTERN_EXCLUDE" "*.cpp")

# install(DIRECTORY "/repo/ws/build/px4/platforms/ros2/rosidl_typesupport_introspection_c/px4/" "DESTINATION" "include/px4/px4" "PATTERN" "*.h")
ament_cmake_symlink_install_directory("/repo/ws/src/px4/platforms/ros2" DIRECTORY "/repo/ws/build/px4/platforms/ros2/rosidl_typesupport_introspection_c/px4/" "DESTINATION" "include/px4/px4" "PATTERN" "*.h")

# install(DIRECTORY "/repo/ws/build/px4/platforms/ros2/rosidl_typesupport_introspection_cpp/px4/" "DESTINATION" "include/px4/px4" "PATTERN" "*.hpp")
ament_cmake_symlink_install_directory("/repo/ws/src/px4/platforms/ros2" DIRECTORY "/repo/ws/build/px4/platforms/ros2/rosidl_typesupport_introspection_cpp/px4/" "DESTINATION" "include/px4/px4" "PATTERN" "*.hpp")

# install(FILES "/repo/ws/build/px4/platforms/ros2/ament_cmake_environment_hooks/pythonpath.sh" "DESTINATION" "share/px4/environment")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/ament_cmake_environment_hooks/pythonpath.sh" "DESTINATION" "share/px4/environment")

# install(FILES "/repo/ws/build/px4/ament_cmake_environment_hooks/pythonpath.dsv" "DESTINATION" "share/px4/environment")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/ament_cmake_environment_hooks/pythonpath.dsv" "DESTINATION" "share/px4/environment")

# install(DIRECTORY "/repo/ws/build/px4/platforms/ros2/ament_cmake_python/px4/px4.egg-info/" "DESTINATION" "local/lib/python3.10/dist-packages/px4-1.14.0-py3.10.egg-info")
ament_cmake_symlink_install_directory("/repo/ws/src/px4/platforms/ros2" DIRECTORY "/repo/ws/build/px4/platforms/ros2/ament_cmake_python/px4/px4.egg-info/" "DESTINATION" "local/lib/python3.10/dist-packages/px4-1.14.0-py3.10.egg-info")

# install(DIRECTORY "/repo/ws/build/px4/platforms/ros2/rosidl_generator_py/px4/" "DESTINATION" "local/lib/python3.10/dist-packages/px4" "PATTERN_EXCLUDE" "*.pyc" "PATTERN_EXCLUDE" "__pycache__")
ament_cmake_symlink_install_directory("/repo/ws/src/px4/platforms/ros2" DIRECTORY "/repo/ws/build/px4/platforms/ros2/rosidl_generator_py/px4/" "DESTINATION" "local/lib/python3.10/dist-packages/px4" "PATTERN_EXCLUDE" "*.pyc" "PATTERN_EXCLUDE" "__pycache__")

# install("TARGETS" "px4__rosidl_typesupport_fastrtps_c__pyext" "DESTINATION" "local/lib/python3.10/dist-packages/px4")
include("/repo/ws/build/px4/platforms/ros2/ament_cmake_symlink_install_targets_0_${CMAKE_INSTALL_CONFIG_NAME}.cmake")

# install("TARGETS" "px4__rosidl_typesupport_introspection_c__pyext" "DESTINATION" "local/lib/python3.10/dist-packages/px4")
include("/repo/ws/build/px4/platforms/ros2/ament_cmake_symlink_install_targets_1_${CMAKE_INSTALL_CONFIG_NAME}.cmake")

# install("TARGETS" "px4__rosidl_typesupport_c__pyext" "DESTINATION" "local/lib/python3.10/dist-packages/px4")
include("/repo/ws/build/px4/platforms/ros2/ament_cmake_symlink_install_targets_2_${CMAKE_INSTALL_CONFIG_NAME}.cmake")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ActionRequest.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ActionRequest.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ActuatorArmed.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ActuatorArmed.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ActuatorControlsStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ActuatorControlsStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ActuatorMotors.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ActuatorMotors.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ActuatorOutputs.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ActuatorOutputs.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ActuatorServos.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ActuatorServos.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ActuatorServosTrim.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ActuatorServosTrim.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ActuatorTest.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ActuatorTest.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/AdcReport.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/AdcReport.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/Airspeed.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/Airspeed.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/AirspeedValidated.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/AirspeedValidated.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/AirspeedWind.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/AirspeedWind.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/AutotuneAttitudeControlStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/AutotuneAttitudeControlStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/BatteryStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/BatteryStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ButtonEvent.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ButtonEvent.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/CameraCapture.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/CameraCapture.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/CameraStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/CameraStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/CameraTrigger.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/CameraTrigger.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/CellularStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/CellularStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/CollisionConstraints.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/CollisionConstraints.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/CollisionReport.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/CollisionReport.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ControlAllocatorStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ControlAllocatorStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/Cpuload.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/Cpuload.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/DebugArray.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/DebugArray.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/DebugKeyValue.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/DebugKeyValue.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/DebugValue.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/DebugValue.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/DebugVect.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/DebugVect.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/DifferentialPressure.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/DifferentialPressure.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/DistanceSensor.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/DistanceSensor.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/Ekf2Timestamps.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/Ekf2Timestamps.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EscReport.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EscReport.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EscStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EscStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorAidSource1d.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorAidSource1d.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorAidSource2d.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorAidSource2d.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorAidSource3d.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorAidSource3d.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorBias.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorBias.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorBias3d.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorBias3d.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorEventFlags.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorEventFlags.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorGpsStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorGpsStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorInnovations.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorInnovations.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorSelectorStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorSelectorStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorSensorBias.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorSensorBias.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorStates.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorStates.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorStatusFlags.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/EstimatorStatusFlags.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/Event.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/Event.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/FailsafeFlags.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/FailsafeFlags.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/FailureDetectorStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/FailureDetectorStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/FollowTarget.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/FollowTarget.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/FollowTargetEstimator.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/FollowTargetEstimator.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/FollowTargetStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/FollowTargetStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/GeneratorStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/GeneratorStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/GeofenceResult.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/GeofenceResult.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/GimbalControls.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/GimbalControls.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/GimbalDeviceAttitudeStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/GimbalDeviceAttitudeStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/GimbalDeviceInformation.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/GimbalDeviceInformation.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/GimbalDeviceSetAttitude.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/GimbalDeviceSetAttitude.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/GimbalManagerInformation.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/GimbalManagerInformation.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/GimbalManagerSetAttitude.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/GimbalManagerSetAttitude.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/GimbalManagerSetManualControl.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/GimbalManagerSetManualControl.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/GimbalManagerStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/GimbalManagerStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/GpsDump.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/GpsDump.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/GpsInjectData.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/GpsInjectData.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/Gripper.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/Gripper.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/HealthReport.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/HealthReport.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/HeaterStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/HeaterStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/HomePosition.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/HomePosition.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/HoverThrustEstimate.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/HoverThrustEstimate.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/InputRc.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/InputRc.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/InternalCombustionEngineStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/InternalCombustionEngineStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/IridiumsbdStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/IridiumsbdStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/IrlockReport.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/IrlockReport.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/LandingGear.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/LandingGear.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/LandingGearWheel.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/LandingGearWheel.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/LandingTargetInnovations.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/LandingTargetInnovations.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/LandingTargetPose.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/LandingTargetPose.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/LaunchDetectionStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/LaunchDetectionStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/LedControl.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/LedControl.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/LogMessage.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/LogMessage.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/LoggerStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/LoggerStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/MagWorkerData.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/MagWorkerData.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/MagnetometerBiasEstimate.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/MagnetometerBiasEstimate.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ManualControlSetpoint.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ManualControlSetpoint.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ManualControlSwitches.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ManualControlSwitches.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/MavlinkLog.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/MavlinkLog.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/MavlinkTunnel.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/MavlinkTunnel.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/Mission.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/Mission.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/MissionResult.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/MissionResult.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ModeCompleted.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ModeCompleted.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/MountOrientation.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/MountOrientation.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/NavigatorMissionItem.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/NavigatorMissionItem.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/NormalizedUnsignedSetpoint.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/NormalizedUnsignedSetpoint.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/NpfgStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/NpfgStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ObstacleDistance.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ObstacleDistance.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/OffboardControlMode.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/OffboardControlMode.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/OnboardComputerStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/OnboardComputerStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/OrbTest.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/OrbTest.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/OrbTestLarge.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/OrbTestLarge.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/OrbTestMedium.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/OrbTestMedium.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/OrbitStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/OrbitStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ParameterUpdate.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/ParameterUpdate.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/Ping.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/Ping.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/PositionControllerLandingStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/PositionControllerLandingStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/PositionControllerStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/PositionControllerStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/PositionSetpoint.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/PositionSetpoint.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/PositionSetpointTriplet.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/PositionSetpointTriplet.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/PowerButtonState.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/PowerButtonState.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/PowerMonitor.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/PowerMonitor.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/PpsCapture.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/PpsCapture.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/PwmInput.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/PwmInput.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/Px4ioStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/Px4ioStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/QshellReq.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/QshellReq.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/QshellRetval.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/QshellRetval.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/RadioStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/RadioStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/RateCtrlStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/RateCtrlStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/RcChannels.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/RcChannels.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/RcParameterMap.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/RcParameterMap.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/Rpm.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/Rpm.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/RtlTimeEstimate.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/RtlTimeEstimate.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SatelliteInfo.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SatelliteInfo.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorAccel.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorAccel.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorAccelFifo.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorAccelFifo.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorBaro.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorBaro.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorCombined.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorCombined.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorCorrection.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorCorrection.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorGnssRelative.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorGnssRelative.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorGps.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorGps.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorGyro.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorGyro.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorGyroFft.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorGyroFft.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorGyroFifo.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorGyroFifo.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorHygrometer.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorHygrometer.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorMag.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorMag.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorOpticalFlow.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorOpticalFlow.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorPreflightMag.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorPreflightMag.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorSelection.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorSelection.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorUwb.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorUwb.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorsStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorsStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorsStatusImu.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SensorsStatusImu.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SystemPower.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/SystemPower.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/TakeoffStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/TakeoffStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/TaskStackInfo.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/TaskStackInfo.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/TecsStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/TecsStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/TelemetryStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/TelemetryStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/TiltrotorExtraControls.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/TiltrotorExtraControls.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/TimesyncStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/TimesyncStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/TrajectoryBezier.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/TrajectoryBezier.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/TrajectorySetpoint.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/TrajectorySetpoint.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/TrajectoryWaypoint.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/TrajectoryWaypoint.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/TransponderReport.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/TransponderReport.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/TuneControl.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/TuneControl.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/UavcanParameterRequest.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/UavcanParameterRequest.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/UavcanParameterValue.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/UavcanParameterValue.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/UlogStream.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/UlogStream.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/UlogStreamAck.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/UlogStreamAck.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleAcceleration.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleAcceleration.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleAirData.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleAirData.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleAngularAccelerationSetpoint.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleAngularAccelerationSetpoint.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleAngularVelocity.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleAngularVelocity.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleAttitude.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleAttitude.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleAttitudeSetpoint.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleAttitudeSetpoint.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleCommand.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleCommand.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleCommandAck.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleCommandAck.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleConstraints.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleConstraints.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleControlMode.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleControlMode.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleGlobalPosition.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleGlobalPosition.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleImu.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleImu.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleImuStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleImuStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleLandDetected.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleLandDetected.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleLocalPosition.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleLocalPosition.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleLocalPositionSetpoint.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleLocalPositionSetpoint.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleMagnetometer.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleMagnetometer.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleOdometry.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleOdometry.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleOpticalFlow.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleOpticalFlow.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleOpticalFlowVel.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleOpticalFlowVel.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleRatesSetpoint.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleRatesSetpoint.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleRoi.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleRoi.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleThrustSetpoint.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleThrustSetpoint.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleTorqueSetpoint.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleTorqueSetpoint.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleTrajectoryBezier.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleTrajectoryBezier.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleTrajectoryWaypoint.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VehicleTrajectoryWaypoint.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VtolVehicleStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/VtolVehicleStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/Wind.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/Wind.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/YawEstimatorStatus.idl" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/build/px4/platforms/ros2/rosidl_adapter/px4/msg/YawEstimatorStatus.idl" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ActionRequest.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ActionRequest.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ActuatorArmed.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ActuatorArmed.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ActuatorControlsStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ActuatorControlsStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ActuatorMotors.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ActuatorMotors.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ActuatorOutputs.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ActuatorOutputs.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ActuatorServos.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ActuatorServos.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ActuatorServosTrim.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ActuatorServosTrim.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ActuatorTest.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ActuatorTest.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/AdcReport.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/AdcReport.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/Airspeed.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/Airspeed.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/AirspeedValidated.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/AirspeedValidated.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/AirspeedWind.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/AirspeedWind.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/AutotuneAttitudeControlStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/AutotuneAttitudeControlStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/BatteryStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/BatteryStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ButtonEvent.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ButtonEvent.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/CameraCapture.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/CameraCapture.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/CameraStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/CameraStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/CameraTrigger.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/CameraTrigger.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/CellularStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/CellularStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/CollisionConstraints.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/CollisionConstraints.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/CollisionReport.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/CollisionReport.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ControlAllocatorStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ControlAllocatorStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/Cpuload.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/Cpuload.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/DebugArray.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/DebugArray.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/DebugKeyValue.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/DebugKeyValue.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/DebugValue.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/DebugValue.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/DebugVect.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/DebugVect.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/DifferentialPressure.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/DifferentialPressure.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/DistanceSensor.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/DistanceSensor.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/Ekf2Timestamps.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/Ekf2Timestamps.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EscReport.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EscReport.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EscStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EscStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorAidSource1d.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorAidSource1d.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorAidSource2d.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorAidSource2d.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorAidSource3d.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorAidSource3d.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorBias.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorBias.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorBias3d.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorBias3d.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorEventFlags.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorEventFlags.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorGpsStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorGpsStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorInnovations.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorInnovations.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorSelectorStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorSelectorStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorSensorBias.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorSensorBias.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorStates.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorStates.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorStatusFlags.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/EstimatorStatusFlags.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/Event.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/Event.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/FailsafeFlags.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/FailsafeFlags.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/FailureDetectorStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/FailureDetectorStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/FollowTarget.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/FollowTarget.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/FollowTargetEstimator.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/FollowTargetEstimator.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/FollowTargetStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/FollowTargetStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/GeneratorStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/GeneratorStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/GeofenceResult.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/GeofenceResult.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/GimbalControls.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/GimbalControls.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/GimbalDeviceAttitudeStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/GimbalDeviceAttitudeStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/GimbalDeviceInformation.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/GimbalDeviceInformation.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/GimbalDeviceSetAttitude.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/GimbalDeviceSetAttitude.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/GimbalManagerInformation.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/GimbalManagerInformation.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/GimbalManagerSetAttitude.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/GimbalManagerSetAttitude.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/GimbalManagerSetManualControl.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/GimbalManagerSetManualControl.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/GimbalManagerStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/GimbalManagerStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/GpsDump.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/GpsDump.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/GpsInjectData.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/GpsInjectData.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/Gripper.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/Gripper.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/HealthReport.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/HealthReport.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/HeaterStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/HeaterStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/HomePosition.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/HomePosition.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/HoverThrustEstimate.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/HoverThrustEstimate.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/InputRc.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/InputRc.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/InternalCombustionEngineStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/InternalCombustionEngineStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/IridiumsbdStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/IridiumsbdStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/IrlockReport.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/IrlockReport.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/LandingGear.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/LandingGear.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/LandingGearWheel.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/LandingGearWheel.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/LandingTargetInnovations.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/LandingTargetInnovations.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/LandingTargetPose.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/LandingTargetPose.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/LaunchDetectionStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/LaunchDetectionStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/LedControl.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/LedControl.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/LogMessage.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/LogMessage.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/LoggerStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/LoggerStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/MagWorkerData.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/MagWorkerData.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/MagnetometerBiasEstimate.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/MagnetometerBiasEstimate.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ManualControlSetpoint.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ManualControlSetpoint.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ManualControlSwitches.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ManualControlSwitches.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/MavlinkLog.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/MavlinkLog.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/MavlinkTunnel.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/MavlinkTunnel.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/Mission.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/Mission.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/MissionResult.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/MissionResult.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ModeCompleted.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ModeCompleted.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/MountOrientation.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/MountOrientation.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/NavigatorMissionItem.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/NavigatorMissionItem.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/NormalizedUnsignedSetpoint.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/NormalizedUnsignedSetpoint.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/NpfgStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/NpfgStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ObstacleDistance.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ObstacleDistance.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/OffboardControlMode.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/OffboardControlMode.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/OnboardComputerStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/OnboardComputerStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/OrbTest.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/OrbTest.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/OrbTestLarge.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/OrbTestLarge.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/OrbTestMedium.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/OrbTestMedium.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/OrbitStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/OrbitStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ParameterUpdate.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/ParameterUpdate.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/Ping.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/Ping.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/PositionControllerLandingStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/PositionControllerLandingStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/PositionControllerStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/PositionControllerStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/PositionSetpoint.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/PositionSetpoint.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/PositionSetpointTriplet.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/PositionSetpointTriplet.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/PowerButtonState.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/PowerButtonState.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/PowerMonitor.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/PowerMonitor.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/PpsCapture.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/PpsCapture.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/PwmInput.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/PwmInput.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/Px4ioStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/Px4ioStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/QshellReq.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/QshellReq.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/QshellRetval.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/QshellRetval.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/RadioStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/RadioStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/RateCtrlStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/RateCtrlStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/RcChannels.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/RcChannels.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/RcParameterMap.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/RcParameterMap.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/Rpm.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/Rpm.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/RtlTimeEstimate.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/RtlTimeEstimate.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SatelliteInfo.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SatelliteInfo.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorAccel.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorAccel.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorAccelFifo.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorAccelFifo.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorBaro.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorBaro.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorCombined.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorCombined.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorCorrection.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorCorrection.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorGnssRelative.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorGnssRelative.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorGps.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorGps.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorGyro.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorGyro.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorGyroFft.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorGyroFft.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorGyroFifo.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorGyroFifo.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorHygrometer.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorHygrometer.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorMag.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorMag.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorOpticalFlow.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorOpticalFlow.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorPreflightMag.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorPreflightMag.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorSelection.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorSelection.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorUwb.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorUwb.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorsStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorsStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorsStatusImu.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SensorsStatusImu.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SystemPower.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/SystemPower.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/TakeoffStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/TakeoffStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/TaskStackInfo.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/TaskStackInfo.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/TecsStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/TecsStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/TelemetryStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/TelemetryStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/TiltrotorExtraControls.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/TiltrotorExtraControls.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/TimesyncStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/TimesyncStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/TrajectoryBezier.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/TrajectoryBezier.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/TrajectorySetpoint.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/TrajectorySetpoint.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/TrajectoryWaypoint.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/TrajectoryWaypoint.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/TransponderReport.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/TransponderReport.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/TuneControl.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/TuneControl.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/UavcanParameterRequest.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/UavcanParameterRequest.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/UavcanParameterValue.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/UavcanParameterValue.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/UlogStream.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/UlogStream.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/UlogStreamAck.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/UlogStreamAck.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleAcceleration.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleAcceleration.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleAirData.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleAirData.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleAngularAccelerationSetpoint.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleAngularAccelerationSetpoint.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleAngularVelocity.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleAngularVelocity.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleAttitude.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleAttitude.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleAttitudeSetpoint.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleAttitudeSetpoint.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleCommand.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleCommand.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleCommandAck.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleCommandAck.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleConstraints.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleConstraints.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleControlMode.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleControlMode.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleGlobalPosition.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleGlobalPosition.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleImu.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleImu.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleImuStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleImuStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleLandDetected.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleLandDetected.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleLocalPosition.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleLocalPosition.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleLocalPositionSetpoint.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleLocalPositionSetpoint.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleMagnetometer.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleMagnetometer.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleOdometry.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleOdometry.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleOpticalFlow.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleOpticalFlow.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleOpticalFlowVel.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleOpticalFlowVel.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleRatesSetpoint.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleRatesSetpoint.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleRoi.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleRoi.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleThrustSetpoint.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleThrustSetpoint.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleTorqueSetpoint.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleTorqueSetpoint.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleTrajectoryBezier.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleTrajectoryBezier.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleTrajectoryWaypoint.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VehicleTrajectoryWaypoint.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VtolVehicleStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/VtolVehicleStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/Wind.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/Wind.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/src/px4/platforms/ros2/../../msg/YawEstimatorStatus.msg" "DESTINATION" "share/px4/msg")
ament_cmake_symlink_install_files("/repo/ws/src/px4/platforms/ros2" FILES "/repo/ws/src/px4/platforms/ros2/../../msg/YawEstimatorStatus.msg" "DESTINATION" "share/px4/msg")

# install(FILES "/repo/ws/build/px4/ament_cmake_index/share/ament_index/resource_index/package_run_dependencies/px4" "DESTINATION" "share/ament_index/resource_index/package_run_dependencies")
ament_cmake_symlink_install_files("/repo/ws/src/px4" FILES "/repo/ws/build/px4/ament_cmake_index/share/ament_index/resource_index/package_run_dependencies/px4" "DESTINATION" "share/ament_index/resource_index/package_run_dependencies")

# install(FILES "/repo/ws/build/px4/ament_cmake_index/share/ament_index/resource_index/parent_prefix_path/px4" "DESTINATION" "share/ament_index/resource_index/parent_prefix_path")
ament_cmake_symlink_install_files("/repo/ws/src/px4" FILES "/repo/ws/build/px4/ament_cmake_index/share/ament_index/resource_index/parent_prefix_path/px4" "DESTINATION" "share/ament_index/resource_index/parent_prefix_path")

# install(FILES "/opt/ros/humble/share/ament_cmake_core/cmake/environment_hooks/environment/ament_prefix_path.sh" "DESTINATION" "share/px4/environment")
ament_cmake_symlink_install_files("/repo/ws/src/px4" FILES "/opt/ros/humble/share/ament_cmake_core/cmake/environment_hooks/environment/ament_prefix_path.sh" "DESTINATION" "share/px4/environment")

# install(FILES "/repo/ws/build/px4/ament_cmake_environment_hooks/ament_prefix_path.dsv" "DESTINATION" "share/px4/environment")
ament_cmake_symlink_install_files("/repo/ws/src/px4" FILES "/repo/ws/build/px4/ament_cmake_environment_hooks/ament_prefix_path.dsv" "DESTINATION" "share/px4/environment")

# install(FILES "/opt/ros/humble/share/ament_cmake_core/cmake/environment_hooks/environment/path.sh" "DESTINATION" "share/px4/environment")
ament_cmake_symlink_install_files("/repo/ws/src/px4" FILES "/opt/ros/humble/share/ament_cmake_core/cmake/environment_hooks/environment/path.sh" "DESTINATION" "share/px4/environment")

# install(FILES "/repo/ws/build/px4/ament_cmake_environment_hooks/path.dsv" "DESTINATION" "share/px4/environment")
ament_cmake_symlink_install_files("/repo/ws/src/px4" FILES "/repo/ws/build/px4/ament_cmake_environment_hooks/path.dsv" "DESTINATION" "share/px4/environment")

# install(FILES "/repo/ws/build/px4/ament_cmake_environment_hooks/local_setup.bash" "DESTINATION" "share/px4")
ament_cmake_symlink_install_files("/repo/ws/src/px4" FILES "/repo/ws/build/px4/ament_cmake_environment_hooks/local_setup.bash" "DESTINATION" "share/px4")

# install(FILES "/repo/ws/build/px4/ament_cmake_environment_hooks/local_setup.sh" "DESTINATION" "share/px4")
ament_cmake_symlink_install_files("/repo/ws/src/px4" FILES "/repo/ws/build/px4/ament_cmake_environment_hooks/local_setup.sh" "DESTINATION" "share/px4")

# install(FILES "/repo/ws/build/px4/ament_cmake_environment_hooks/local_setup.zsh" "DESTINATION" "share/px4")
ament_cmake_symlink_install_files("/repo/ws/src/px4" FILES "/repo/ws/build/px4/ament_cmake_environment_hooks/local_setup.zsh" "DESTINATION" "share/px4")

# install(FILES "/repo/ws/build/px4/ament_cmake_environment_hooks/local_setup.dsv" "DESTINATION" "share/px4")
ament_cmake_symlink_install_files("/repo/ws/src/px4" FILES "/repo/ws/build/px4/ament_cmake_environment_hooks/local_setup.dsv" "DESTINATION" "share/px4")

# install(FILES "/repo/ws/build/px4/ament_cmake_environment_hooks/package.dsv" "DESTINATION" "share/px4")
ament_cmake_symlink_install_files("/repo/ws/src/px4" FILES "/repo/ws/build/px4/ament_cmake_environment_hooks/package.dsv" "DESTINATION" "share/px4")

# install(FILES "/repo/ws/build/px4/ament_cmake_index/share/ament_index/resource_index/packages/px4" "DESTINATION" "share/ament_index/resource_index/packages")
ament_cmake_symlink_install_files("/repo/ws/src/px4" FILES "/repo/ws/build/px4/ament_cmake_index/share/ament_index/resource_index/packages/px4" "DESTINATION" "share/ament_index/resource_index/packages")

# install(FILES "/repo/ws/build/px4/ament_cmake_core/px4Config.cmake" "/repo/ws/build/px4/ament_cmake_core/px4Config-version.cmake" "DESTINATION" "share/px4/cmake")
ament_cmake_symlink_install_files("/repo/ws/src/px4" FILES "/repo/ws/build/px4/ament_cmake_core/px4Config.cmake" "/repo/ws/build/px4/ament_cmake_core/px4Config-version.cmake" "DESTINATION" "share/px4/cmake")

# install(FILES "/repo/ws/src/px4/package.xml" "DESTINATION" "share/px4")
ament_cmake_symlink_install_files("/repo/ws/src/px4" FILES "/repo/ws/src/px4/package.xml" "DESTINATION" "share/px4")
