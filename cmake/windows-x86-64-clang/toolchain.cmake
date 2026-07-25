set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR "x86_64")

# Locate clang-cl via vswhere rather than a hardcoded path, since the Visual
# Studio install (and therefore VC/Tools/Llvm) is not guaranteed to be on the
# same drive as Program Files.
find_program(VSWHERE_EXECUTABLE vswhere
    PATHS "$ENV{ProgramFiles\(x86\)}/Microsoft Visual Studio/Installer"
)

if(NOT VSWHERE_EXECUTABLE)
    message(FATAL_ERROR "vswhere.exe not found; cannot locate the Visual Studio clang-cl toolset")
endif()

execute_process(
    COMMAND "${VSWHERE_EXECUTABLE}" -latest -products * -find VC/Tools/Llvm/x64/bin/clang-cl.exe
    OUTPUT_VARIABLE CLANG_CL_EXECUTABLE
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

if(NOT CLANG_CL_EXECUTABLE)
    message(FATAL_ERROR "Could not locate clang-cl.exe under the Visual Studio installation (VC/Tools/Llvm/x64/bin). Install the \"C++ Clang Compiler for Windows\" component.")
endif()

# vswhere may list more than one match if multiple VS instances are installed.
string(REGEX MATCH "^[^\r\n]+" CLANG_CL_EXECUTABLE "${CLANG_CL_EXECUTABLE}")

set(CMAKE_C_COMPILER "${CLANG_CL_EXECUTABLE}" CACHE FILEPATH "")
set(CMAKE_CXX_COMPILER "${CLANG_CL_EXECUTABLE}" CACHE FILEPATH "")

if(NOT DEFINED ENV{VCPKG_ROOT})
    set(VCPKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/.vcpkg)
else()
    set(VCPKG_ROOT $ENV{VCPKG_ROOT})
endif()

include("${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake")
