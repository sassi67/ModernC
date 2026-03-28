cmake_minimum_required(VERSION 4.2)

project(ModernC)

add_executable(app main.c)
target_link_libraries(app PRIVATE lib)
