cmake_minimum_required(VERSION 3.10)

project(blueprint)

if(CMAKE_BUILD_TYPE STREQUAL "")
        # CMake defaults to leaving CMAKE_BUILD_TYPE empty. This screws up
        # differentiation between debug and release builds.
        set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "Choose the type of build, options are: None (CMAKE_CXX_FLAGS or CMAKE_C_FLAGS used) Debug Release." FORCE)
endif()

if(LINUX)
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DLINUX")
endif(LINUX)
if(WIN32)
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DWIN32")
endif(WIN32)
# set(CMAKE_C_STANDARD 11)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY lib/${CMAKE_BUILD_TYPE})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY bin/${CMAKE_BUILD_TYPE})

include(FetchContent)
FetchContent_Declare(
        Zlib
        GIT_REPOSITORY https://github.com/madler/zlib
        GIT_TAG v1.3.1.2
)
FetchContent_Declare(
        Base64
        GIT_REPOSITORY https://github.com/aklomp/base64.git
        GIT_TAG v0.5.2
)
FetchContent_MakeAvailable(Zlib Base64)

include_directories(
        ./
        ./include
        ./hdr
        ./lib/hdr
)


file(
        GLOB_RECURSE
        lib_files
        CONFIGURE_DEPENDS
        lib/*.c
        src/*.c # Finally, library and executable have same src files ???
)

file(
        GLOB_RECURSE
        bin_files
        CONFIGURE_DEPENDS
        lib/*.c
        src/*.c
)

add_library(
        ${PROJECT_NAME}
        SHARED
        ${lib_files}

)

target_link_libraries(
        ${PROJECT_NAME}
        PUBLIC
        base64
        ZLIB::ZLIB

)

add_executable(
        ${PROJECT_NAME}_exe
        ${bin_files}
)

target_link_libraries(
        ${PROJECT_NAME}_exe
        PUBLIC
        # ${PROJECT_NAME}
        base64
        ZLIB::ZLIBSTATIC
)
