cmake_minimum_required(VERSION 2.8)
project( gtk-tutorial )

include( cmakepp/cmakepp.cmake )

find_package(PkgConfig REQUIRED)
pkg_check_modules(GTK3 REQUIRED gtk+-3.0)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

#add_subdirectory( gl )
#add_subdirectory( GtkGLArea )
add_subdirectory( external )

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

add_executable( example-3 example-3.cpp )
target_link_libraries( example-3 ${GTK3_LIBRARIES} )

add_executable( example-4 example-4.cpp )
target_link_libraries( example-4 ${GTK3_LIBRARIES} )
add_custom_target( example-4-copy-resources
	COMMAND ${CMAKE_COMMAND} -E copy_if_different builder.ui "${PROJECT_BINARY_DIR}"
	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
)
add_dependencies( example-4 example-4-copy-resources )


#configure_file( "exampleapp.gresource.xml.in" "${PROJECT_BINARY_DIR}/exampleapp.gresource.xml" )
add_custom_command( OUTPUT ${PROJECT_BINARY_DIR}/resources.c ${PROJECT_BINARY_DIR}/resources.h
    COMMAND glib-compile-resources "exampleapp.gresource.xml" --target="${PROJECT_BINARY_DIR}/resources.c" --generate-source
    COMMAND glib-compile-resources "exampleapp.gresource.xml" --target="${PROJECT_BINARY_DIR}/resources.h" --generate-header
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
)

add_executable( example-5
    example-5.c
    exampleapp.h exampleapp.c
    exampleappwin.h exampleappwin.c
    ${PROJECT_BINARY_DIR}/resources.h ${PROJECT_BINARY_DIR}/resources.c
)
target_link_libraries( example-5 ${GTK3_LIBRARIES} )
