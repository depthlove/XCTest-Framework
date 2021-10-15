#!/bin/bash
root_path=`pwd`

#build
mkdir -p build/ios
cd build/ios

# archs=("x86_64" "arm64")
archs=("x86_64")
for arch in ${archs[@]};do
    cmake -G "Xcode" ../../ -DCMAKE_TOOLCHAIN_FILE=../../cmake/toolchains/ios.cmake -DIOS_ACTIVE_ARCH="${arch}" -DENABLE_DEMO=ON
done

open ${root_path}/build/ios/iOSFramework.xcodeproj
