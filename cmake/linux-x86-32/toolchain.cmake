set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR "x86")

set(CMAKE_C_COMPILER gcc)
set(CMAKE_CXX_COMPILER g++)

# 32-bit build via gcc multilib support; requires the g++-multilib /
# gcc-multilib packages (and matching 32-bit vcpkg dependencies).
set(CMAKE_C_FLAGS_INIT "-m32")
set(CMAKE_CXX_FLAGS_INIT "-m32")
set(CMAKE_EXE_LINKER_FLAGS_INIT "-m32")
set(CMAKE_SHARED_LINKER_FLAGS_INIT "-m32")
set(CMAKE_MODULE_LINKER_FLAGS_INIT "-m32")

# VCPKG_TARGET_TRIPLET is set by the CMake preset (cacheVariables), not here:
# the root CMakeLists.txt invokes `vcpkg install` before project() runs, i.e.
# before this toolchain file is even included, so it must already be cached.

if(NOT DEFINED ENV{VCPKG_ROOT})
    set(VCPKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/.vcpkg)
else()
    set(VCPKG_ROOT $ENV{VCPKG_ROOT})
endif()

include("${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake")
