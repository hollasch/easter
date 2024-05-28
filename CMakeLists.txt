cmake_minimum_required(VERSION 3.2...3.29.3)

project (drives LANGUAGES CXX)

add_executable (easter easter.cpp)
target_link_libraries(easter Mpr.lib)
