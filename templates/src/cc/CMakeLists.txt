cmake_minimum_required(VERSION 3.30.5)
project(test)

set(CMAKE_C_STANDARD 17)
# set(CMAKE_CXX_STANDARD 23) 
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_executable(test  src/main.c)
# add_executable(test  src/main.cpp)
