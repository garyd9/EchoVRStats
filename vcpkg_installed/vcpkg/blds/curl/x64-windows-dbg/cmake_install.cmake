# Install script for directory: C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/src/url-8_19_0-541fed44c9.clean

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/pkgs/curl_x64-windows/debug")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "OFF")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/x64-windows-dbg/scripts/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/x64-windows-dbg/lib/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/x64-windows-dbg/docs/examples/cmake_install.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE FILE PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE FILES "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/x64-windows-dbg/curl-config")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/x64-windows-dbg/libcurl.pc")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/src/url-8_19_0-541fed44c9.clean/include/curl" FILES_MATCHING REGEX "/[^/]*\\.h$")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/CURL/CURLTargets.cmake")
    file(DIFFERENT _cmake_export_file_changed FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/CURL/CURLTargets.cmake"
         "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/x64-windows-dbg/CMakeFiles/Export/8e83d16133499b505bf3986f4f209a65/CURLTargets.cmake")
    if(_cmake_export_file_changed)
      file(GLOB _cmake_old_config_files "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/CURL/CURLTargets-*.cmake")
      if(_cmake_old_config_files)
        string(REPLACE ";" ", " _cmake_old_config_files_text "${_cmake_old_config_files}")
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/CURL/CURLTargets.cmake\" will be replaced.  Removing files [${_cmake_old_config_files_text}].")
        unset(_cmake_old_config_files_text)
        file(REMOVE ${_cmake_old_config_files})
      endif()
      unset(_cmake_old_config_files)
    endif()
    unset(_cmake_export_file_changed)
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/CURL" TYPE FILE FILES "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/x64-windows-dbg/CMakeFiles/Export/8e83d16133499b505bf3986f4f209a65/CURLTargets.cmake")
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/CURL" TYPE FILE FILES "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/x64-windows-dbg/CMakeFiles/Export/8e83d16133499b505bf3986f4f209a65/CURLTargets-debug.cmake")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/CURL" TYPE FILE FILES
    "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/x64-windows-dbg/generated/CURLConfigVersion.cmake"
    "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/x64-windows-dbg/generated/CURLConfig.cmake"
    "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/src/url-8_19_0-541fed44c9.clean/CMake/FindBrotli.cmake"
    "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/src/url-8_19_0-541fed44c9.clean/CMake/FindCares.cmake"
    "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/src/url-8_19_0-541fed44c9.clean/CMake/FindGSS.cmake"
    "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/src/url-8_19_0-541fed44c9.clean/CMake/FindGnuTLS.cmake"
    "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/src/url-8_19_0-541fed44c9.clean/CMake/FindLDAP.cmake"
    "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/src/url-8_19_0-541fed44c9.clean/CMake/FindLibbacktrace.cmake"
    "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/src/url-8_19_0-541fed44c9.clean/CMake/FindLibgsasl.cmake"
    "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/src/url-8_19_0-541fed44c9.clean/CMake/FindLibidn2.cmake"
    "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/src/url-8_19_0-541fed44c9.clean/CMake/FindLibpsl.cmake"
    "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/src/url-8_19_0-541fed44c9.clean/CMake/FindLibrtmp.cmake"
    "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/src/url-8_19_0-541fed44c9.clean/CMake/FindLibssh.cmake"
    "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/src/url-8_19_0-541fed44c9.clean/CMake/FindLibssh2.cmake"
    "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/src/url-8_19_0-541fed44c9.clean/CMake/FindLibuv.cmake"
    "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/src/url-8_19_0-541fed44c9.clean/CMake/FindMbedTLS.cmake"
    "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/src/url-8_19_0-541fed44c9.clean/CMake/FindNGHTTP2.cmake"
    "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/src/url-8_19_0-541fed44c9.clean/CMake/FindNGHTTP3.cmake"
    "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/src/url-8_19_0-541fed44c9.clean/CMake/FindNGTCP2.cmake"
    "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/src/url-8_19_0-541fed44c9.clean/CMake/FindNettle.cmake"
    "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/src/url-8_19_0-541fed44c9.clean/CMake/FindQuiche.cmake"
    "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/src/url-8_19_0-541fed44c9.clean/CMake/FindRustls.cmake"
    "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/src/url-8_19_0-541fed44c9.clean/CMake/FindWolfSSL.cmake"
    "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/src/url-8_19_0-541fed44c9.clean/CMake/FindZstd.cmake"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE FILE PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE FILES "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/src/url-8_19_0-541fed44c9.clean/scripts/wcurl")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/x64-windows-dbg/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
if(CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_COMPONENT MATCHES "^[a-zA-Z0-9_.+-]+$")
    set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
  else()
    string(MD5 CMAKE_INST_COMP_HASH "${CMAKE_INSTALL_COMPONENT}")
    set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INST_COMP_HASH}.txt")
    unset(CMAKE_INST_COMP_HASH)
  endif()
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "C:/Users/garyd/source/repos/EchoVRStats/vcpkg_installed/vcpkg/blds/curl/x64-windows-dbg/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
