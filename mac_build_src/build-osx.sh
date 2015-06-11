#!/bin/bash
#
# OS X 32-bit
# Copyright (C) polynation games ltd - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Christopher Redden, December 2013

cd luavm
make clean
make macosx CC="gcc -m32" BUILDMODE=static
cp src/liblua.a ../osx/liblua_x86.a

make clean
make macosx CC="gcc" BUILDMODE=static
cp src/liblua.a ../osx/liblua_x86_64.a

cd ../osx/
xcodebuild
cd ..

mkdir -p ./Plugins
cp -r ./osx/build/Release/ulua.bundle ./Plugins/
