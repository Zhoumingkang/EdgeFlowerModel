cmake_minimum_required( VERSION 3.2 )
project( external )
include( ExternalProject )
include( CMakePrintHelpers )

#file(
#	COPY ${CMAKE_CURRENT_SOURCE_DIR}
#	DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/..
#)

if ( NOT DEFINED EXTERNAL_PREFIX_DIR )
	#set( EXTERNAL_PREFIX_DIR ${CMAKE_BINARY_DIR} PARENT_SCOPE )
	#set( EXTERNAL_PREFIX_DIR ${CMAKE_BINARY_DIR} )
	set( EXTERNAL_PREFIX_DIR ${CMAKE_BINARY_DIR}/install CACHE path "external libraries build path" FORCE )
endif()

if ( NOT DEFINED EXTERNAL_HEADER_DIR )
	#set( EXTERNAL_HEADER_DIR ${EXTERNAL_PREFIX_DIR}/include PARENT_SCOPE )
	#set( EXTERNAL_HEADER_DIR ${EXTERNAL_PREFIX_DIR}/include )
	set( EXTERNAL_HEADER_DIR ${EXTERNAL_PREFIX_DIR}/include CACHE internal "" FORCE )
endif()

if ( NOT DEFINED EXTERNAL_LINKING_DIR )
	#set( EXTERNAL_LINKING_DIR ${EXTERNAL_PREFIX_DIR}/lib ${EXTERNAL_PREFIX_DIR}/bin PARENT_SCOPE )
	#set( EXTERNAL_LINKING_DIR ${EXTERNAL_PREFIX_DIR}/lib ${EXTERNAL_PREFIX_DIR}/bin )
	set( EXTERNAL_LINKING_DIR ${EXTERNAL_PREFIX_DIR}/lib ${EXTERNAL_PREFIX_DIR}/bin CACHE internal "" FORCE )
endif()

include(ProcessorCount)
ProcessorCount(N)
if(NOT N EQUAL 0)
  set(MAKE_FLAGS -j${N})
endif()

set( CONFIGURE_COMMAND "./configure" )
find_program( MAKE_COMMAND make )
set( BUILD_ENV
	#CFLAGS=-I${EXTERNAL_PREFIX_DIR}/include
	#CPPFLAGS=-I${EXTERNAL_PREFIX_DIR}/include
	#LDFLAGS=-L${EXTERNAL_PREFIX_DIR}/lib#:-L${EXTERNAL_PREFIX_DIR}/bin
	PKG_CONFIG_PATH=${EXTERNAL_PREFIX_DIR}/lib/pkgconfig
	#GLIB_CFLAGS=-I${EXTERNAL_PREFIX_DIR}/include/glib-2.0 -I${EXTERNAL_PREFIX_DIR}/lib/glib-2.0/include
	#GLIB_LIBS=-L${EXTERNAL_PREFIX_DIR}/lib
	#PKG_CONFIG_PATH=${EXTERNAL_PREFIX_DIR}
	# DYLD_FALLBACK_LIBRARY_PATH=
	C_INCLUDE_PATH=${EXTERNAL_PREFIX_DIR}/include
	LD_LIBRARY_PATH=${EXTERNAL_PREFIX_DIR}/lib
	#LD_RUN_PATH=${EXTERNAL_PREFIX_DIR}/lib
	#SDL_LIBS=-L${EXTERNAL_PREFIX_DIR}/lib
	#LIBPNG_LIBS=-L${EXTERNAL_PREFIX_DIR}/lib
	#LIBPNG_LDFLAGS=${LDFLAGS}
	#LIBPNG_CFLAGS=${CFLAGS}
)

include_directories( ${EXTERNAL_HEADER_DIR} )
link_directories( ${EXTERNAL_LINKING_DIR} )

find_package(PkgConfig REQUIRED)
execute_process(
  COMMAND ${PKG_CONFIG_EXECUTABLE} --variable pc_path pkg-config
  OUTPUT_VARIABLE PKG_CONFIG_BUILD_IN_SEARCH_PATH
)
message( "PKG_CONFIG_BUILD_IN_SEARCH_PATH = ${PKG_CONFIG_BUILD_IN_SEARCH_PATH}" )

ExternalProject_Add( build_xz
  URL "http://tukaani.org/xz/xz-5.2.1.tar.xz"
  BUILD_IN_SOURCE 1
  CONFIGURE_COMMAND ${BUILD_ENV} ${CONFIGURE_COMMAND} --prefix=${EXTERNAL_PREFIX_DIR} --exec-prefix=${EXTERNAL_PREFIX_DIR}
  BUILD_COMMAND ${BUILD_ENV} ${MAKE_COMMAND} ${MAKE_FLAGS}
)

ExternalProject_Add( build_python
  URL "https://www.python.org/ftp/python/3.4.3/Python-3.4.3.tar.xz"
  BUILD_IN_SOURCE 1
  CONFIGURE_COMMAND ${BUILD_ENV} ${CONFIGURE_COMMAND} --prefix=${EXTERNAL_PREFIX_DIR} --exec-prefix=${EXTERNAL_PREFIX_DIR}
  BUILD_COMMAND ${BUILD_ENV} ${MAKE_COMMAND} ${MAKE_FLAGS}
	DEPENDS build_xz
)

ExternalProject_Add( build_cairo
  URL "http://cairographics.org/releases/cairo-1.14.2.tar.xz"
  BUILD_IN_SOURCE 1
  CONFIGURE_COMMAND ${BUILD_ENV} ${CONFIGURE_COMMAND} --prefix=${EXTERNAL_PREFIX_DIR} --exec-prefix=${EXTERNAL_PREFIX_DIR}
  BUILD_COMMAND ${BUILD_ENV} ${MAKE_COMMAND} ${MAKE_FLAGS}
)

ExternalProject_Add( build_glib
  URL "http://ftp.gnome.org/pub/gnome/sources/glib/2.44/glib-2.44.0.tar.xz"
  BUILD_IN_SOURCE 1
  CONFIGURE_COMMAND ${BUILD_ENV} ${CONFIGURE_COMMAND} --prefix=${EXTERNAL_PREFIX_DIR} --exec-prefix=${EXTERNAL_PREFIX_DIR}
  BUILD_COMMAND ${BUILD_ENV} ${MAKE_COMMAND} ${MAKE_FLAGS}
)

ExternalProject_Add( build_gobject-introspection
  DEPENDS build_glib
  URL "http://ftp.gnome.org/pub/gnome/sources/gobject-introspection/1.44/gobject-introspection-1.44.0.tar.xz"
  BUILD_IN_SOURCE 1
  CONFIGURE_COMMAND ${BUILD_ENV} ${CONFIGURE_COMMAND} --prefix=${EXTERNAL_PREFIX_DIR} --exec-prefix=${EXTERNAL_PREFIX_DIR}
  BUILD_COMMAND ${BUILD_ENV} ${MAKE_COMMAND} ${MAKE_FLAGS}
)

ExternalProject_Add( build_pango
  DEPENDS build_glib
  URL "http://ftp.gnome.org/pub/gnome/sources/pango/1.36/pango-1.36.8.tar.xz"
  BUILD_IN_SOURCE 1
  CONFIGURE_COMMAND ${BUILD_ENV} ${CONFIGURE_COMMAND} --prefix=${EXTERNAL_PREFIX_DIR} --exec-prefix=${EXTERNAL_PREFIX_DIR}
  BUILD_COMMAND ${BUILD_ENV} ${MAKE_COMMAND} ${MAKE_FLAGS}
)

ExternalProject_Add( build_gdk-pixbuf
  DEPENDS build_glib
  URL "http://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/2.30/gdk-pixbuf-2.30.8.tar.xz"
  BUILD_IN_SOURCE 1
  CONFIGURE_COMMAND ${BUILD_ENV} ${CONFIGURE_COMMAND} --prefix=${EXTERNAL_PREFIX_DIR} --exec-prefix=${EXTERNAL_PREFIX_DIR}
  BUILD_COMMAND ${BUILD_ENV} ${MAKE_COMMAND} ${MAKE_FLAGS}
)

ExternalProject_Add( build_atk
  DEPENDS build_glib
  URL "http://ftp.gnome.org/pub/gnome/sources/atk/2.16/atk-2.16.0.tar.xz"
  BUILD_IN_SOURCE 1
  CONFIGURE_COMMAND ${BUILD_ENV} ${CONFIGURE_COMMAND} --prefix=${EXTERNAL_PREFIX_DIR} --exec-prefix=${EXTERNAL_PREFIX_DIR}
  BUILD_COMMAND ${BUILD_ENV} ${MAKE_COMMAND} ${MAKE_FLAGS}
)

ExternalProject_Add( build_gtk
  DEPENDS build_glib build_pango build_gdk-pixbuf build_atk build_gobject-introspection build_cairo
  URL "http://ftp.gnome.org/pub/gnome/sources/gtk+/3.16/gtk+-3.16.1.tar.xz"
  BUILD_IN_SOURCE 1
  CONFIGURE_COMMAND ${BUILD_ENV} ${CONFIGURE_COMMAND} --prefix=${EXTERNAL_PREFIX_DIR} --exec-prefix=${EXTERNAL_PREFIX_DIR}
  BUILD_COMMAND ${BUILD_ENV} ${MAKE_COMMAND} ${MAKE_FLAGS}
)
