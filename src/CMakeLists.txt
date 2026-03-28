cmake_minimum_required(VERSION 4.2)

add_library(lib
  lib/lib.c
)
target_include_directories(lib PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/lib/include>
  $<INSTALL_INTERFACE:include>
)
# Example: compile options common across platforms
target_compile_options(lib PRIVATE
  $<$<C_COMPILER_ID:GNU,Clang>:-Wall -Wextra -Wpedantic>
)

# cmake_minimum_required(VERSION 4.2)

# project(lib C CXX)

# file(GLOB LIB_FILES 
#     "${CMAKE_CURRENT_SOURCE_DIR}/lib/*.c"
#     "${CMAKE_CURRENT_SOURCE_DIR}/lib/include/*.h"
# )

# add_library(${PROJECT_NAME} SHARED STATIC ${LIB_FILES})