cmake_minimum_required(VERSION 3.4.1)

enable_testing()
find_package(XCTest REQUIRED)
set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_ALLOWED "NO")
set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_REQUIRED "NO")
set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "")

set(CUSTOM_OUTPUT_NAME iOSFrameworkTests)

include_directories(./iOSFrameworkTests)

FILE(GLOB_RECURSE SOURCES 
    "./*.h" 
    "./*.pch" 
    "./*.cc" 
    "./*.m" 
    "./*.mm"
)

FILE(GLOB_RECURSE RESOURCES 
    "./test_files/*.txt"
)

source_group(Resources FILES ${RESOURCES})

xctest_add_bundle(iOSFrameworkTests iOSFramework
    ${SOURCES}
    ${RESOURCES}
)

set_target_properties(iOSFrameworkTests PROPERTIES
    MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_SOURCE_DIR}/Info.plist
    RESOURCE "${RESOURCES}"
    OUTPUT_NAME ${CUSTOM_OUTPUT_NAME}
)