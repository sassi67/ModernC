set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR "x86_64")

set(CMAKE_C_COMPILER gcc)
set(CMAKE_CXX_COMPILER g++)

# VCPKG_TARGET_TRIPLET is set by the CMake preset (cacheVariables), not here:
# the root CMakeLists.txt invokes `vcpkg install` before project() runs, i.e.
# before this toolchain file is even included, so it must already be cached.

if(NOT DEFINED ENV{VCPKG_ROOT})
    set(VCPKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/.vcpkg)
else()
    set(VCPKG_ROOT $ENV{VCPKG_ROOT})
endif()

include("${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake")
