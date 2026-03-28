cmake_minimum_required(VERSION 4.2)

project(ModernCTest LANGUAGES CXX)

# Use GTest provided by vcpkg
find_package(GTest CONFIG REQUIRED)

file(GLOB TEST_FILES 
    "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/*.h"
)

add_executable(${PROJECT_NAME} ${TEST_FILES})
target_link_libraries(${PROJECT_NAME} PRIVATE 
    GTest::gtest
    GTest::gtest_main
    lib
)
target_include_directories(${PROJECT_NAME} PRIVATE 
    "${CMAKE_CURRENT_SOURCE_DIR}/../src" 
)
add_test(NAME ${PROJECT_NAME} COMMAND ${PROJECT_NAME})
