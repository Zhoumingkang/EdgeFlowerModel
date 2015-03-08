cmake_minimum_required(VERSION 2.8)
project( gtk-tutorial )

include( CMakePrintHelpers )

set( CMAKE_C_STANDARD 99 )
set( CMAKE_C_STANDARD_REQUIRED ON )

find_package( PkgConfig REQUIRED )
pkg_check_modules( GTK3 REQUIRED gtk+-3.0 )

include_directories( ${GTK3_INCLUDE_DIRS} )
link_directories( ${GTK3_LIBRARY_DIRS} )
add_definitions( ${GTK3_CFLAGS_OTHER} )

find_package( X11 REQUIRED )
include_directories( ${X11_INCLUDE_DIR} )

find_package( PkgConfig REQUIRED )
pkg_check_modules( GDK3 REQUIRED gdk-3.0 )

cmake_print_variables( GDK3_INCLUDE_DIRS GDK3_LIBRARY_DIRS GDK3_CFLAGS_OTHER GDK3_LIBRARIES )
include_directories( ${GDK3_INCLUDE_DIRS} )
link_directories( ${GDK3_LIBRARY_DIRS} )
add_definitions( ${GDK3_CFLAGS_OTHER} )

#/opt/X11
if( APPLE )
  set( OPENGL_gl_LIBRARY "/opt/X11/lib/libGL.dylib" )
  set( OPENGL_glu_LIBRARY "/opt/X11/lib/libGLU.dylib" )
endif()
find_package( OpenGL )
cmake_print_variables( OPENGL_LIBRARIES )
include_directories( ${OPENGL_INCLUDE_DIR} )

# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
# if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
#   set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++")
# endif()

add_executable( tegtkgl main.c tegtkgl.h tegtkgl.c )
target_link_libraries( tegtkgl ${GTK3_LIBRARIES} ${X11_LIBRARIES} ${GDK3_LIBRARIES} ${OPENGL_LIBRARIES} )
