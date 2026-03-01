# Cross-compilation for STM32MP135F-DK (OpenSTLinux SDK)
# SDK environment must be sourced before running cmake:
#   source /opt/st/stm32mp1/sdk/environment-setup-cortexa7t2hf-neon-vfpv4-ostl-linux-gnueabi

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

# The SDK sets CC="arm-ostl-linux-gnueabi-gcc <flags>" (compiler + flags in one var).
# CMake needs them split: CMAKE_C_COMPILER = executable only, flags go into CMAKE_C_FLAGS.
# Same for CXX.

# --- Split CC into compiler and flags ---
separate_arguments(_CC_LIST UNIX_COMMAND "$ENV{CC}")
list(GET _CC_LIST 0 _CC_COMPILER)
list(REMOVE_AT _CC_LIST 0)
string(REPLACE ";" " " _CC_FLAGS "${_CC_LIST}")

separate_arguments(_CXX_LIST UNIX_COMMAND "$ENV{CXX}")
list(GET _CXX_LIST 0 _CXX_COMPILER)
list(REMOVE_AT _CXX_LIST 0)
string(REPLACE ";" " " _CXX_FLAGS "${_CXX_LIST}")

set(CMAKE_C_COMPILER   ${_CC_COMPILER})
set(CMAKE_CXX_COMPILER ${_CXX_COMPILER})
set(CMAKE_C_FLAGS_INIT   "${_CC_FLAGS}")
set(CMAKE_CXX_FLAGS_INIT "${_CXX_FLAGS}")

set(CMAKE_SYSROOT $ENV{SDKTARGETSYSROOT})

set(CMAKE_FIND_ROOT_PATH $ENV{SDKTARGETSYSROOT})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# pkg-config must look inside sysroot
set(ENV{PKG_CONFIG_PATH}        "$ENV{SDKTARGETSYSROOT}/usr/lib/pkgconfig:$ENV{SDKTARGETSYSROOT}/usr/share/pkgconfig")
set(ENV{PKG_CONFIG_SYSROOT_DIR} "$ENV{SDKTARGETSYSROOT}")