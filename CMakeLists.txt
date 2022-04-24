cmake_minimum_required(VERSION 3.11)
project(librop)

if (NOT CMAKE_C_COMPILER_ID STREQUAL "Clang")
  message(FATAL_ERROR "librop needs to be compiled with Clang. Please set CC and CXX accordingly.")
endif()

add_library(rop SHARED librop.c)

set(VERSION_MAJOR 1)
set(VERSION_MINOR 0)
set(VERSION_PATCH 0)
set(VERSION_STRING ${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH})

set_target_properties(rop PROPERTIES VERSION ${VERSION_STRING} SOVERSION
                                                               ${VERSION_MAJOR})

# librop has to be compiled as a 32-bit library
if (CMAKE_SIZEOF_VOID_P EQUAL 8)
    set_target_properties(rop PROPERTIES COMPILE_FLAGS "-m32" LINK_FLAGS "-m32")
endif()

target_compile_options(rop PRIVATE "-fasm-blocks")

add_custom_command(
  OUTPUT librop.c
  DEPENDS genlib.py
  COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/genlib.py)

install(TARGETS rop LIBRARY)
