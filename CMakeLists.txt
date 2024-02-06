cmake_minimum_required(VERSION 3.26)
project(cua CUDA)

set(CMAKE_CUDA_STANDARD 17)

add_executable(cua main.cu)

set_target_properties(cua PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)
