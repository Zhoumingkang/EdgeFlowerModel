cmake_minimum_required(VERSION 2.8)
project( GtkGLArea )

include( CMakePrintHelpers )

set( CMAKE_C_STANDARD 99 )
set( CMAKE_C_STANDARD_REQUIRED ON )

find_package( PkgConfig REQUIRED )
pkg_check_modules( GTK3 REQUIRED gtk+-3.0 )

include_directories( ${GTK3_INCLUDE_DIRS} )
link_directories( ${GTK3_LIBRARY_DIRS} )
add_definitions( ${GTK3_CFLAGS_OTHER} )

cmake_print_variables( GDK3_INCLUDE_DIRS GDK3_LIBRARY_DIRS GDK3_CFLAGS_OTHER GDK3_LIBRARIES )
include_directories( ${GDK3_INCLUDE_DIRS} )
link_directories( ${GDK3_LIBRARY_DIRS} )
add_definitions( ${GDK3_CFLAGS_OTHER} )

find_package( OpenGL )
cmake_print_variables( OPENGL_LIBRARIES )
include_directories( ${OPENGL_INCLUDE_DIR} )

add_executable( GtkGLArea
  glarea-app.c
  glarea-app-window.c
  glarea-error.c
  glarea-resources.c
  glarea-app.h
  glarea-app-window.h
  glarea-error.h
  main.c
)
target_link_libraries( GtkGLArea ${GTK3_LIBRARIES} ${GDK3_LIBRARIES} ${OPENGL_LIBRARIES} )

