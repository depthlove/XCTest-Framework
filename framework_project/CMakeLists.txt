CMAKE_MINIMUM_REQUIRED(VERSION 3.4.1)

project(iOSFramework)

option(ENABLE_DEMO "enable demo" OFF)
set(ENABLE_DEMO ${ENABLE_DEMO} CACHE BOOL "enable demo" FORCE)

if(${CMAKE_SYSTEM_NAME} MATCHES "iOS")
    message(STATUS "detect ios")
    set(PLATFORM ios)
endif()

if(${CMAKE_SYSTEM_NAME} MATCHES "iOS")
    set(CMAKE_CXX_STANDARD 11)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)
    set(CMAKE_CXX_EXTENSIONS ON)
endif()

message(STATUS "current path: ${PROJECT_SOURCE_DIR}")

set(SDK_PATH ${PROJECT_SOURCE_DIR}/iOSFramework)

include_directories(${SDK_PATH}/iOSFramework)

set(SDK_SOURCE
    ${SDK_PATH}/iOSFramework/iOSFramework.h 
    ${SDK_PATH}/iOSFramework/STMLogger.h
    ${SDK_PATH}/iOSFramework/STMLogger.m
)

add_library(iOSFramework STATIC ${SDK_SOURCE})

if(${CMAKE_SYSTEM_NAME} MATCHES "iOS")
    target_link_libraries(
        iOSFramework
        "-framework Foundation"
        "-framework UIKit"
    )

    #add third lib
    #set(PRELINK_LIBS "${THIRD_PARTY_PATH}/lib/libABCD.a")
    #set_target_properties(iOSFramework PROPERTIES
    #    XCODE_ATTRIBUTE_GENERATE_MASTER_OBJECT_FILE "YES"
    #    XCODE_ATTRIBUTE_PRELINK_LIBS ${PRELINK_LIBS}
    #   XCODE_ATTRIBUTE_PRELINK_FLAGS "-ObjC"
    #)

    set_target_properties(iOSFramework PROPERTIES
        FRAMEWORK TRUE
        XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH "NO"
        XCODE_ATTRIBUTE_ALWAYS_SEARCH_USER_PATHS "NO"
        XCODE_ATTRIBUTE_USE_HEADERMAP "YES"
        XCODE_ATTRIBUTE_CLANG_ENABLE_MODULES "YES"
        XCODE_ATTRIBUTE_CLANG_ENABLE_OBJC_ARC "YES"
        XCODE_ATTRIBUTE_CLANG_ENABLE_OBJC_WEAK "YES"
        XCODE_ATTRIBUTE_CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING "YES"
        XCODE_ATTRIBUTE_CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF "YES"
        XCODE_ATTRIBUTE_DEBUG_INFORMATION_FORMAT "dwarf-with-dsym"
    )

    if(${CMAKE_SYSTEM_NAME} MATCHES "iOS")
        set_target_properties(iOSFramework PROPERTIES
            XCODE_ATTRIBUTE_ENABLE_BITCODE "YES"
            XCODE_ATTRIBUTE_OTHER_CFLAGS[variant=Debug] "-fembed-bitcode-marker"
            XCODE_ATTRIBUTE_OTHER_CFLAGS[variant=Release] "-fembed-bitcode"
            XCODE_ATTRIBUTE_BITCODE_GENERATION_MODE[variant=Debug] "marker"
            XCODE_ATTRIBUTE_BITCODE_GENERATION_MODE[variant=Release] "bitcode"
        )
    endif()

    set(PUBLIC_HEADERS
        ${SDK_PATH}/iOSFramework/iOSFramework.h
        ${SDK_PATH}/iOSFramework/STMLogger.h
    )

    set_target_properties(iOSFramework PROPERTIES
        XCODE_ATTRIBUTE_DEFINES_MODULE "YES"
        XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER "iOSFramework"
        PUBLIC_HEADER "${PUBLIC_HEADERS}"
        OUTPUT_NAME "iOSFramework"
    )
endif()

#add example
set(EXAMPLE_PATH ${PROJECT_SOURCE_DIR}/iOSFrameworkTests)
if(${CMAKE_SYSTEM_NAME} MATCHES "iOS")
    if(ENABLE_DEMO)
        add_subdirectory(${EXAMPLE_PATH})
    endif()
endif()