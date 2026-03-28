cmake_minimum_required(VERSION 4.2)

# if the environment variable VCPKG_ROOT is not set
# default to the local .vcpkg directory and clone vcpkg if it doesn't exist
if(NOT DEFINED ENV{VCPKG_ROOT})
    set(VCPKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/.vcpkg)
else()
    set(VCPKG_ROOT $ENV{VCPKG_ROOT})
endif()

if(NOT EXISTS ${VCPKG_ROOT})
    message("Cloning vcpkg in ${VCPKG_ROOT}")
    execute_process(COMMAND git clone https://github.com/Microsoft/vcpkg.git ${VCPKG_ROOT})
else()
    # The following command has no effect if the vcpkg repository is in a detached head state.
    message("Auto-updating vcpkg in ${VCPKG_ROOT}")
    execute_process(COMMAND git pull WORKING_DIRECTORY ${VCPKG_ROOT})
endif()

if(NOT EXISTS ${VCPKG_ROOT}/README.md)
    message(FATAL_ERROR "***** FATAL ERROR: Could not clone vcpkg *****")
endif()

if(WIN32)
    set(VCPKG_EXEC ${VCPKG_ROOT}/vcpkg.exe)
    set(VCPKG_BOOTSTRAP ${VCPKG_ROOT}/bootstrap-vcpkg.bat)
else()
    set(VCPKG_EXEC ${VCPKG_ROOT}/vcpkg)
    set(VCPKG_BOOTSTRAP ${VCPKG_ROOT}/bootstrap-vcpkg.sh)
endif()

if(NOT EXISTS ${VCPKG_EXEC})
    message("Bootstrapping vcpkg in ${VCPKG_ROOT}")
    execute_process(COMMAND ${VCPKG_BOOTSTRAP} WORKING_DIRECTORY ${VCPKG_ROOT})
endif()

if(NOT EXISTS ${VCPKG_EXEC})
    message(FATAL_ERROR "***** FATAL ERROR: Could not bootstrap vcpkg *****")
endif()

if(WIN32)
    if(DEFINED CMAKE_GENERATOR_PLATFORM AND CMAKE_GENERATOR_PLATFORM)
        if(CMAKE_GENERATOR_PLATFORM STREQUAL "Win32")
            set(VCPKG_TARGET_TRIPLET "x86-windows" CACHE STRING "")
        else()
            set(VCPKG_TARGET_TRIPLET "${CMAKE_GENERATOR_PLATFORM}-windows" CACHE STRING "")
        endif()
    else()
        set(VCPKG_TARGET_TRIPLET "x64-windows" CACHE STRING "" )
    endif()
endif()

set(CPROJECT_DEPENDENCIES 
    GTest:${VCPKG_TARGET_TRIPLET} 
)
set(GTest_DIR ${VCPKG_ROOT}/installed/${VCPKG_TARGET_TRIPLET}/share/gtest CACHE STRING "")

message(STATUS "***** Checking project third party dependencies in ${VCPKG_ROOT} *****")
execute_process(COMMAND ${VCPKG_EXEC} install ${CPROJECT_DEPENDENCIES} WORKING_DIRECTORY ${VCPKG_ROOT})

project(ModernC LANGUAGES C CXX)

# Enforce C11 for C targets
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

# Build type default
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build." FORCE)
endif()

# Enable testing before adding subdirectories that register tests
enable_testing()

# Add subprojects
add_subdirectory(src)
add_subdirectory(app)
add_subdirectory(tests)
