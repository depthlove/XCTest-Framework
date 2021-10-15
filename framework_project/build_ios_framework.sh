#!/bin/bash

#build
mkdir -p build/ios
cd build/ios

CURRENT_PATH=`pwd`

archs=("x86_64" "arm64")
for arch in ${archs[@]};do
    cmake -G "Xcode" ../../ -DCMAKE_TOOLCHAIN_FILE=../../cmake/toolchains/ios.cmake -DIOS_ACTIVE_ARCH="${arch}" -DENABLE_DEMO=OFF
    cmake --build . --config Release
done

#lipo
SDK_NAME="iOSFramework"
IPHONEOS_SDK="Release-iphoneos/${SDK_NAME}.framework"
IPHONESIMULATOR_SDK="Release-iphonesimulator/${SDK_NAME}.framework"
RELEASE_SDK="Release/${SDK_NAME}.framework"

rm -rf ${RELEASE_SDK}
mkdir -p ${RELEASE_SDK}

lipo -create ${IPHONEOS_SDK}/${SDK_NAME} ${IPHONESIMULATOR_SDK}/${SDK_NAME} -output ${RELEASE_SDK}/${SDK_NAME}

cp -rf ${IPHONEOS_SDK}/Headers ${RELEASE_SDK}/Headers
cp ${IPHONEOS_SDK}/Info.plist ${RELEASE_SDK}/Info.plist
cp -rf ${IPHONEOS_SDK}/Modules ${RELEASE_SDK}/Modules

lipo -info ${RELEASE_SDK}/${SDK_NAME}
echo "ls ${CURRENT_PATH}/${RELEASE_SDK}"
ls ${RELEASE_SDK}