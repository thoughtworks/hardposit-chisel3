cmake_minimum_required(VERSION 3.14)
project(PositTestGenerator)

include_directories(universal/include/posit)

add_executable(PositTestGenerator PositTestGenerator.cpp PositTestGenerator.hpp
        GenUnaryTest.hpp GenBinaryTest.hpp GenTernaryTest.hpp
        GenCompareTest.hpp GenConversionTest.hpp WriteCases.hpp)

add_executable(F2PConvertor F2PConvertor.cpp)

add_executable(P2FConvertor P2FConvertor.cpp)

set(CMAKE_CXX_FLAGS "-march=native -mtune=generic")
set(CMAKE_CXX_COMPILER g++)