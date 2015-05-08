cmake_minimum_required(VERSION 3.2)
project( tutorial )

include( CMakePrintHelpers )
include( GNUInstallDirs )

cmake_print_variables( CMAKE_PREFIX_PATH )
cmake_print_variables( CMAKE_INSTALL_PREFIX )

cmake_print_variables( CMAKE_INSTALL_BINDIR )
cmake_print_variables( CMAKE_INSTALL_SBINDIR )
cmake_print_variables( CMAKE_INSTALL_LIBEXECDIR )
cmake_print_variables( CMAKE_INSTALL_SYSCONFDIR )
cmake_print_variables( CMAKE_INSTALL_SHAREDSTATEDIR )
cmake_print_variables( CMAKE_INSTALL_LOCALSTATEDIR )
cmake_print_variables( CMAKE_INSTALL_LIBDIR )
cmake_print_variables( CMAKE_INSTALL_INCLUDEDIR )
cmake_print_variables( CMAKE_INSTALL_OLDINCLUDEDIR )
cmake_print_variables( CMAKE_INSTALL_DATAROOTDIR )
cmake_print_variables( CMAKE_INSTALL_DATADIR )
cmake_print_variables( CMAKE_INSTALL_INFODIR )
cmake_print_variables( CMAKE_INSTALL_LOCALEDIR )
cmake_print_variables( CMAKE_INSTALL_MANDIR )
cmake_print_variables( CMAKE_INSTALL_DOCDIR )

cmake_print_variables( CMAKE_INSTALL_FULL_BINDIR )
cmake_print_variables( CMAKE_INSTALL_FULL_SBINDIR )
cmake_print_variables( CMAKE_INSTALL_FULL_LIBEXECDIR )
cmake_print_variables( CMAKE_INSTALL_FULL_SYSCONFDIR )
cmake_print_variables( CMAKE_INSTALL_FULL_SHAREDSTATEDIR )
cmake_print_variables( CMAKE_INSTALL_FULL_LOCALSTATEDIR )
cmake_print_variables( CMAKE_INSTALL_FULL_LIBDIR )
cmake_print_variables( CMAKE_INSTALL_FULL_INCLUDEDIR )
cmake_print_variables( CMAKE_INSTALL_FULL_OLDINCLUDEDIR )
cmake_print_variables( CMAKE_INSTALL_FULL_DATAROOTDIR )
cmake_print_variables( CMAKE_INSTALL_FULL_DATADIR )
cmake_print_variables( CMAKE_INSTALL_FULL_INFODIR )
cmake_print_variables( CMAKE_INSTALL_FULL_LOCALEDIR )
cmake_print_variables( CMAKE_INSTALL_FULL_MANDIR )
cmake_print_variables( CMAKE_INSTALL_FULL_DOCDIR )

find_package(PkgConfig REQUIRED)
pkg_check_modules(GTK3 REQUIRED gtk+-3.0>=3.16)

message( STATUS "external_BINARY_DIR ${external_BINARY_DIR}" )
message( STATUS "GTK3_VERSION ${GTK3_VERSION}" )
message( STATUS "PKG_CONFIG_PATH ${PKG_CONFIG_PATH}" )

include_directories(${GTK3_INCLUDE_DIRS})
link_directories(${GTK3_LIBRARY_DIRS})
add_definitions(${GTK3_CFLAGS_OTHER})


add_executable( example-1 example-1.cpp )
target_link_libraries( example-1 ${GTK3_LIBRARIES} )
install( TARGETS example-1 DESTINATION "${CMAKE_PREFIX_PATH}/${CMAKE_INSTALL_BINDIR}" )

add_executable( example-2 example-2.cpp )
target_link_libraries( example-2 ${GTK3_LIBRARIES} )
install( TARGETS example-2 DESTINATION "${CMAKE_PREFIX_PATH}/${CMAKE_INSTALL_BINDIR}" )

add_executable( example-3 example-3.cpp )
target_link_libraries( example-3 ${GTK3_LIBRARIES} )
install( TARGETS example-3 DESTINATION "${CMAKE_PREFIX_PATH}/${CMAKE_INSTALL_BINDIR}" )

#add_executable( example-4 example-4.cpp )
#target_link_libraries( example-4 ${GTK3_LIBRARIES} )
#add_custom_target( example-4-copy-resources
#	COMMAND ${CMAKE_COMMAND} -E copy_if_different builder.ui "${PROJECT_BINARY_DIR}"
#	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
#)
#add_dependencies( example-4 example-4-copy-resources )

#add_custom_command( OUTPUT ${PROJECT_BINARY_DIR}/resources.c ${PROJECT_BINARY_DIR}/resources.h
#    COMMAND glib-compile-resources "exampleapp.gresource.xml" --target="${PROJECT_BINARY_DIR}/resources.c" --generate-source
#    COMMAND glib-compile-resources "exampleapp.gresource.xml" --target="${PROJECT_BINARY_DIR}/resources.h" --generate-header
#    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
#    DEPENDS exampleapp.gresource.xml window.ui app-menu.ui
#)

#add_executable( example-5
#    example-5.c
#    exampleapp.h exampleapp.c
#    exampleappwin.h exampleappwin.c
#    ${PROJECT_BINARY_DIR}/resources.h ${PROJECT_BINARY_DIR}/resources.c
#)
#target_link_libraries( example-5 ${GTK3_LIBRARIES} )
