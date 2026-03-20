# CMakeList.txt : CMake project for EchoVRStats, include source and define
# project specific logic here.
#
cmake_minimum_required (VERSION 3.10)
set(CMAKE_TOOLCHAIN_FILE "C:/Program Files/Microsoft Visual Studio/18/Enterprise/VC/vcpkg/scripts/buildsystems/vcpkg.cmake" CACHE STRING "Vcpkg toolchain file")

# Enable Hot Reload for MSVC compilers if supported.
if (POLICY CMP0141)
  cmake_policy(SET CMP0141 NEW)
  set(CMAKE_MSVC_DEBUG_INFORMATION_FORMAT "$<IF:$<AND:$<C_COMPILER_ID:MSVC>,$<CXX_COMPILER_ID:MSVC>>,$<$<CONFIG:Debug,RelWithDebInfo>:EditAndContinue>,$<$<CONFIG:Debug,RelWithDebInfo>:ProgramDatabase>>")
endif()

project ("EchoVRStats")

find_package(CURL REQUIRED)
find_package(cxxopts CONFIG REQUIRED)

# Add source to this project's executable.
add_executable (EchoVRStats "EchoVRStats.cpp" "EchoVRStats.h")


if (CMAKE_VERSION VERSION_GREATER 3.12)
  set_property(TARGET EchoVRStats PROPERTY CXX_STANDARD 20)
endif()

#target_link_libraries(MyApp PRIVATE YourLibraryName::YourLibraryTarget) # Link to the target
#    find_package(nlohmann_json CONFIG REQUIRED)
#    target_link_libraries(main PRIVATE nlohmann_json::nlohmann_json)
include(FetchContent)
FetchContent_Declare(
  prometheus-cpp-lite
  GIT_REPOSITORY https://github.com/biaks/prometheus-cpp-lite.git
  GIT_TAG        "master"
)
FetchContent_MakeAvailable(prometheus-cpp-lite)

target_link_libraries(EchoVRStats PRIVATE CURL::libcurl prometheus-cpp-lite cxxopts::cxxopts)
