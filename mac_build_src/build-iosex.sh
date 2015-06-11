#!/bin/bash
#
# OS X 32-bit

# Copyright (C) polynation games ltd - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Christopher Redden, December 2013

LUAJIT=./luajit
DEVDIR=`xcode-select -print-path`/Platforms
IOSVER=iPhoneOS8.1.sdk
IOSDIR=$DEVDIR/iPhoneOS.platform/Developer
IOSBIN=/usr/bin/

BUILD_DIR=$LUAJIT/build

rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR
rm *.a 1>/dev/null 2>/dev/null

echo =================================================
echo ARMV7 Architecture
ISDKF="-arch armv7 -isysroot $IOSDIR/SDKs/$IOSVER"
make -j -C $LUAJIT HOST_CC="gcc -m32 " CROSS=$IOSBIN TARGET_FLAGS="$ISDKF" TARGET=armv7 TARGET_SYS=iOS clean
make -j -C $LUAJIT HOST_CC="gcc -m32 " CROSS=$IOSBIN TARGET_FLAGS="$ISDKF" TARGET=armv7 TARGET_SYS=iOS
mv $LUAJIT/src/libluajit.a $BUILD_DIR/libluajitA7.a

echo =================================================
echo ARM64 Architecture
ISDKF="-arch arm64 -isysroot $IOSDIR/SDKs/$IOSVER"
make -j -C $LUAJIT HOST_CC="gcc " CROSS=$IOSBIN TARGET_FLAGS="$ISDKF" TARGET=arm64 TARGET_SYS=iOS clean
make -j -C $LUAJIT HOST_CC="gcc " CROSS=$IOSBIN TARGET_FLAGS="$ISDKF" TARGET=arm64 TARGET_SYS=iOS
mv $LUAJIT/src/libluajit.a $BUILD_DIR/libluajit64bit.a

libtool -o $BUILD_DIR/libluajit21.a $BUILD_DIR/*.a 2> /dev/null

