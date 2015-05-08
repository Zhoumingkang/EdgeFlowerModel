cmake_minimum_required( VERSION 3.2 )
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

set(MAKE_FLAGS --silent)
include(ProcessorCount)
ProcessorCount(N)
if(NOT N EQUAL 0)
  set(MAKE_FLAGS ${MAKE_FLAGS} -j${N})
endif()

set( CONFIGURE_COMMAND "./configure" )
find_program( MAKE_COMMAND make )

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
  CONFIGURE_COMMAND ${BUILD_ENV} ${CONFIGURE_COMMAND} --quiet --prefix=${EXTERNAL_PREFIX_DIR} --exec-prefix=${EXTERNAL_PREFIX_DIR}
	DOWNLOAD_NO_PROGRESS 1 LOG_DOWNLOAD 0 LOG_UPDATE 0 LOG_CONFIGURE 0 LOG_BUILD 0 LOG_TEST 0 LOG_INSTALL 0
)

ExternalProject_Add( build_python
	DEPENDS build_xz
  URL "https://www.python.org/ftp/python/3.4.3/Python-3.4.3.tar.xz"
  BUILD_IN_SOURCE 1
  CONFIGURE_COMMAND ${BUILD_ENV} ${CONFIGURE_COMMAND} --quiet --prefix=${EXTERNAL_PREFIX_DIR} --exec-prefix=${EXTERNAL_PREFIX_DIR}
	DOWNLOAD_NO_PROGRESS 1 LOG_DOWNLOAD 0 LOG_UPDATE 0 LOG_CONFIGURE 0 LOG_BUILD 0 LOG_TEST 0 LOG_INSTALL 0
)

ExternalProject_Add( build_cairo
  URL "http://cairographics.org/releases/cairo-1.14.2.tar.xz"
  BUILD_IN_SOURCE 1
  CONFIGURE_COMMAND ${BUILD_ENV} ${CONFIGURE_COMMAND} --quiet --prefix=${EXTERNAL_PREFIX_DIR} --exec-prefix=${EXTERNAL_PREFIX_DIR}
	DOWNLOAD_NO_PROGRESS 1 LOG_DOWNLOAD 0 LOG_UPDATE 0 LOG_CONFIGURE 0 LOG_BUILD 0 LOG_TEST 0 LOG_INSTALL 0
)

#ExternalProject_Add( build_fam
#  URL "http://oss.sgi.com/projects/fam/download/fam-latest.tar.gz"
#  BUILD_IN_SOURCE 1
#  CONFIGURE_COMMAND ${BUILD_ENV} ${CONFIGURE_COMMAND} --quiet --prefix=${EXTERNAL_PREFIX_DIR} --exec-prefix=${EXTERNAL_PREFIX_DIR}
#  BUILD_COMMAND ${BUILD_ENV} ${MAKE_COMMAND} ${MAKE_FLAGS}
#	DOWNLOAD_NO_PROGRESS 1 LOG_DOWNLOAD 0 LOG_UPDATE 0 LOG_CONFIGURE 0 LOG_BUILD 0 LOG_TEST 0 LOG_INSTALL 0
#)

ExternalProject_Add( build_glib
#	DEPENDS build_fam
  URL "http://ftp.gnome.org/pub/gnome/sources/glib/2.44/glib-2.44.0.tar.xz"
  BUILD_IN_SOURCE 1
  CONFIGURE_COMMAND ${BUILD_ENV} ${CONFIGURE_COMMAND} --quiet --prefix=${EXTERNAL_PREFIX_DIR} --exec-prefix=${EXTERNAL_PREFIX_DIR}
	DOWNLOAD_NO_PROGRESS 1 LOG_DOWNLOAD 0 LOG_UPDATE 0 LOG_CONFIGURE 0 LOG_BUILD 0 LOG_TEST 0 LOG_INSTALL 0
)

ExternalProject_Add( build_gobject-introspection
  DEPENDS build_glib
  URL "http://ftp.gnome.org/pub/gnome/sources/gobject-introspection/1.44/gobject-introspection-1.44.0.tar.xz"
  BUILD_IN_SOURCE 1
  CONFIGURE_COMMAND ${BUILD_ENV} ${CONFIGURE_COMMAND} --quiet --prefix=${EXTERNAL_PREFIX_DIR} --exec-prefix=${EXTERNAL_PREFIX_DIR}
	DOWNLOAD_NO_PROGRESS 1 LOG_DOWNLOAD 0 LOG_UPDATE 0 LOG_CONFIGURE 0 LOG_BUILD 0 LOG_TEST 0 LOG_INSTALL 0
)

ExternalProject_Add( build_pango
  DEPENDS build_glib
  URL "http://ftp.gnome.org/pub/gnome/sources/pango/1.36/pango-1.36.8.tar.xz"
  BUILD_IN_SOURCE 1
  CONFIGURE_COMMAND ${BUILD_ENV} ${CONFIGURE_COMMAND} --quiet --prefix=${EXTERNAL_PREFIX_DIR} --exec-prefix=${EXTERNAL_PREFIX_DIR}
  DOWNLOAD_NO_PROGRESS 1 LOG_DOWNLOAD 0 LOG_UPDATE 0 LOG_CONFIGURE 0 LOG_BUILD 0 LOG_TEST 0 LOG_INSTALL 0
)

ExternalProject_Add( build_gdk-pixbuf
  DEPENDS build_glib
  URL "http://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/2.30/gdk-pixbuf-2.30.8.tar.xz"
  BUILD_IN_SOURCE 1
  CONFIGURE_COMMAND ${BUILD_ENV} ${CONFIGURE_COMMAND} --quiet --prefix=${EXTERNAL_PREFIX_DIR} --exec-prefix=${EXTERNAL_PREFIX_DIR}
  DOWNLOAD_NO_PROGRESS 1 LOG_DOWNLOAD 0 LOG_UPDATE 0 LOG_CONFIGURE 0 LOG_BUILD 0 LOG_TEST 0 LOG_INSTALL 0
)

ExternalProject_Add( build_atk
  DEPENDS build_glib
  URL "http://ftp.gnome.org/pub/gnome/sources/atk/2.16/atk-2.16.0.tar.xz"
  BUILD_IN_SOURCE 1
  CONFIGURE_COMMAND ${BUILD_ENV} ${CONFIGURE_COMMAND} --quiet --prefix=${EXTERNAL_PREFIX_DIR} --exec-prefix=${EXTERNAL_PREFIX_DIR}
  DOWNLOAD_NO_PROGRESS 1 LOG_DOWNLOAD 0 LOG_UPDATE 0 LOG_CONFIGURE 0 LOG_BUILD 0 LOG_TEST 0 LOG_INSTALL 0
)

ExternalProject_Add( build_gtk
  DEPENDS build_glib build_pango build_gdk-pixbuf build_atk build_gobject-introspection build_cairo
  URL "http://ftp.gnome.org/pub/gnome/sources/gtk+/3.16/gtk+-3.16.1.tar.xz"
  BUILD_IN_SOURCE 1
  CONFIGURE_COMMAND ${BUILD_ENV} ${CONFIGURE_COMMAND} --quiet --prefix=${EXTERNAL_PREFIX_DIR} --exec-prefix=${EXTERNAL_PREFIX_DIR}
  DOWNLOAD_NO_PROGRESS 1 LOG_DOWNLOAD 0 LOG_UPDATE 0 LOG_CONFIGURE 0 LOG_BUILD 0 LOG_TEST 0 LOG_INSTALL 0
)

ExternalProject_Add( build_gtk-mac-bundler
  DEPENDS build_gtk
  URL "http://ftp.acc.umu.se/pub/gnome/sources/gtk-mac-bundler/0.7/gtk-mac-bundler-0.7.4.tar.xz"
  BUILD_IN_SOURCE 1
  CONFIGURE_COMMAND ${CMAKE_COMMAND} -E echo configure_gtk-mac-bundler
  DOWNLOAD_NO_PROGRESS 1 LOG_DOWNLOAD 0 LOG_UPDATE 0 LOG_CONFIGURE 0 LOG_BUILD 0 LOG_TEST 0 LOG_INSTALL 0
)
