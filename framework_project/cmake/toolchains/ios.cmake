#-------------------------------------------------------------------------------
# ios.toolchain.cmake
# cmake toolchain file for cross-compiling to iOS from macOS.
#
#   NOTE that iOS support requires at least cmake 3.14!
# 
# available parameters:
# 
# IOS_ACTIVE_ARCH - Only build active architecture, default ON
# IOS_ONLY_ACTIVE_ARCH - Only build active architecture, default ON
# IOS_USE_ARC - wheter to use ARC, default ON
# IOS_EXCEPTIONS - whether to enable exceptions, default OFF
# IOS_RTTI - whether to enable exceptions, default OFF
#-------------------------------------------------------------------------------

if(NOT IOS_ACTIVE_ARCH)
    set(IOS_ACTIVE_ARCH "arm64")
endif()

message(STATUS "IOS_ACTIVE_ARCH ${IOS_ACTIVE_ARCH}")

set(CMAKE_SYSTEM_NAME iOS)
set(CMAKE_OSX_ARCHITECTURES "${IOS_ACTIVE_ARCH}")
#set(CMAKE_XCODE_ATTRIBUTE_ARCHS[sdk=iphoneos*] "${IOS_ACTIVE_ARCH}")
set(CMAKE_XCODE_EFFECTIVE_PLATFORMS "-iphoneos;-iphonesimulator")
#set(CMAKE_XCODE_ATTRIBUTE_VALID_ARCHS "arm64 armv7")

if(IOS_ACTIVE_ARCH STREQUAL "arm64" OR IOS_ACTIVE_ARCH STREQUAL "armv7")
    set(CMAKE_XCODE_ATTRIBUTE_ARCHS[sdk=iphoneos*] "${IOS_ACTIVE_ARCH}")
    set(CMAKE_OSX_SYSROOT "iphoneos")
elseif(IOS_ACTIVE_ARCH STREQUAL "x86_64" OR IOS_ACTIVE_ARCH STREQUAL "i386")
    set(CMAKE_XCODE_ATTRIBUTE_ARCHS[sdk=iphonesimulator*] "${IOS_ACTIVE_ARCH}")
    set(CMAKE_OSX_SYSROOT "iphonesimulator")
else()
     message(FATAL_ERROR "unknown IOS_ACTIVE_ARCH ${IOS_ACTIVE_ARCH}")
endif()

set(CMAKE_SYSTEM_PROCESSOR ${IOS_ACTIVE_ARCH})

# ios deplayment target for third party libs, when build third_party libs ,open it.
set(CMAKE_OSX_DEPLOYMENT_TARGET "")
set(CMAKE_XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET "9.0")

message(STATUS "CMAKE_OSX_DEPLOYMENT_TARGET ${CMAKE_OSX_DEPLOYMENT_TARGET}")
message(STATUS "CMAKE_XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET ${CMAKE_XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET}")

# Fix for PThread library not in path
set(CMAKE_THREAD_LIBS_INIT "-lpthread")
set(CMAKE_HAVE_THREADS_LIBRARY 1)
set(CMAKE_USE_WIN32_THREADS_INIT 0)
set(CMAKE_USE_PTHREADS_INIT 1)