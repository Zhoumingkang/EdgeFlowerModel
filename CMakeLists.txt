cmake_minimum_required(VERSION 2.8)
project( gtk-tutorial )

find_package(PkgConfig REQUIRED)
pkg_check_modules(GTK3 REQUIRED gtk+-3.0)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include_directories(${GTK3_INCLUDE_DIRS})
link_directories(${GTK3_LIBRARY_DIRS})
add_definitions(${GTK3_CFLAGS_OTHER})

# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
# if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
#   set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++")
# endif()

add_executable( example-1 example-1.cpp )
target_link_libraries( example-1 ${GTK3_LIBRARIES} )

add_executable( example-2 example-2.cpp )
target_link_libraries( example-2 ${GTK3_LIBRARIES} )
