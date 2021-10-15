cmake_minimum_required(VERSION 3.4.1)

enable_testing()
find_package(XCTest REQUIRED)

include_directories(./iOSApp)

set(CUSTOM_OUTPUT_NAME iOSApp)

FILE(GLOB_RECURSE SOURCES 
    "./iOSApp/*.h" 
    "./iOSApp/*.pch" 
    "./iOSApp/*.cc" 
    "./iOSApp/*.m" 
    "./iOSApp/*.mm"
)

FILE(GLOB_RECURSE RESOURCES 
    "./iOSApp/Base.lproj/*.storyboard"
    "./iOSApp/*.storyboard"
    "./iOSApp/*.xib"
)

LIST(APPEND RESOURCES 
    "./iOSApp/Assets.xcassets"
)

set(EXAMPLE_SRC ${SOURCES} ${RESOURCES})

foreach(file ${SOURCES})
    file(RELATIVE_PATH relative_file "${CMAKE_CURRENT_LIST_DIR}/iOSApp" ${file})
    get_filename_component(dir "${relative_file}" PATH)
    if (NOT "${dir}" STREQUAL "")
        string(REPLACE "/" "\\" dir ${dir})
        source_group("${dir}" FILES ${file})
    endif()
endforeach()

source_group(Resources FILES ${RESOURCES})

add_executable(iOSApp MACOSX_BUNDLE ${EXAMPLE_SRC})

target_compile_options(iOSApp PRIVATE -fobjc-arc "$<$<COMPILE_LANGUAGE:CXX>:-std=c++11>")

target_link_libraries(iOSApp 
    iOSFramework 
    "-framework Foundation"
    "-framework UIKit"
    "-framework Metal"
)

set_target_properties(iOSApp PROPERTIES
    MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_LIST_DIR}/iOSApp/Info.plist
    RESOURCE "${RESOURCES}"
    XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER "com.tms.iOSApp"
    XCODE_ATTRIBUTE_LD_RUNPATH_SEARCH_PATHS "@executable_path/../Frameworks @loader_path/Frameworks"
    XCODE_ATTRIBUTE_CLANG_ENABLE_OBJC_ARC "YES"
    XCODE_ATTRIBUTE_GCC_ENABLE_CPP_RTTI "NO"
    XCODE_ATTRIBUTE_CLANG_CXX_LANGUAGE_STANDARD "c++11"
    XCODE_ATTRIBUTE_CLANG_CXX_LIBRARY "libc++"
    XCODE_ATTRIBUTE_GCC_PRECOMPILE_PREFIX_HEADER "YES"
    XCODE_ATTRIBUTE_GCC_PREFIX_HEADER ""
    XCODE_ATTRIBUTE_FRAMEWORK_SEARCH_PATHS ""
    XCODE_ATTRIBUTE_LIBRARY_SEARCH_PATHS ""
    XCODE_ATTRIBUTE_OTHER_CODE_SIGN_FLAGS "--deep"
    OUTPUT_NAME ${CUSTOM_OUTPUT_NAME}
)

#Add XCTest
set(CUSTOM_OUTPUT_NAME iOSFrameworkTests)

include_directories(./iOSFrameworkTests)

FILE(GLOB_RECURSE SOURCES 
    "${CMAKE_CURRENT_LIST_DIR}/../iOSFrameworkTests/*.h" 
    "${CMAKE_CURRENT_LIST_DIR}/../iOSFrameworkTests/*.pch" 
    "${CMAKE_CURRENT_LIST_DIR}/../iOSFrameworkTests/*.cc" 
    "${CMAKE_CURRENT_LIST_DIR}/../iOSFrameworkTests/*.m" 
    "${CMAKE_CURRENT_LIST_DIR}/../iOSFrameworkTests/*.mm"
)

FILE(GLOB_RECURSE RESOURCES 
    "${CMAKE_CURRENT_LIST_DIR}/../iOSFrameworkTests/test_files/*.txt"
)

source_group(Resources FILES ${RESOURCES})

xctest_add_bundle(iOSFrameworkTests iOSApp
    ${SOURCES}
    ${RESOURCES}
)

set_target_properties(iOSFrameworkTests PROPERTIES
    MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_LIST_DIR}/../iOSFrameworkTests/Info.plist
    XCODE_ATTRIBUTE_FRAMEWORK_SEARCH_PATHS "$(BUILD_DIR)/../$(CONFIGURATION)$(EFFECTIVE_PLATFORM_NAME)"
    RESOURCE "${RESOURCES}"
    OUTPUT_NAME ${CUSTOM_OUTPUT_NAME}
)

target_link_libraries(iOSFrameworkTests PRIVATE "-framework iOSFramework")
target_link_libraries(iOSFrameworkTests PRIVATE "-framework Foundation")
target_link_libraries(iOSFrameworkTests PRIVATE "-framework UIKit")
target_link_libraries(iOSFrameworkTests PRIVATE "-framework Metal")

