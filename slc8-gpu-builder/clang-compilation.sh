#!/bin/bash

rm -Rf /opt/clang
yum install -y patchelf
pip3 install alibuild
aliBuild analytics off
aliBuild init
aliBuild --defaults o2 build CMake
git clone https://github.com/llvm/llvm-project.git
pushd llvm-project/llvm/projects
git clone https://github.com/KhronosGroup/SPIRV-LLVM-Translator.git
popd
mkdir llvm-project/build
pushd llvm-project/build
../../sw/slc8_x86-64/CMake/latest/bin/cmake ../llvm -DLLVM_ENABLE_PROJECTS="clang" -DBUILD_SHARED_LIBS=On -DCMAKE_BUILD_TYPE=MinSizeRel -DCMAKE_INSTALL_PREFIX=/opt/clang
make -j 128 install
popd
patchelf --set-rpath '/opt/clang/lib' /opt/clang/bin/llvm-spirv
pushd /opt
tar -cf /clang13.tar clang
cd /
bzip2 -9 clang13.tar
popd
