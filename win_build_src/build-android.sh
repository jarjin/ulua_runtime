# Android/ARM, armeabi-v7a (ARMv7 VFP), Android 4.0+ (ICS)
mkdir -p android/armv7-a

cd ./luajit/
NDK=D:/adt-bundle-windows/android-ndk-r8d
NDKABI=14
NDKVER=$NDK/toolchains/arm-linux-androideabi-4.7
NDKP=$NDKVER/prebuilt/windows/bin/arm-linux-androideabi-
NDKF="--sysroot $NDK/platforms/android-$NDKABI/arch-arm -march=armv7-a"
GCC=$NDKVER/prebuilt/windows/bin/arm-linux-androideabi-gcc
CPPDIR=$NDK/platforms/android-14/arch-arm/usr/include
LIBDIR=$NDK/platforms/android-14/arch-arm/usr/lib

make clean
make HOST_CC="gcc -m32" CROSS=$NDKP TARGET_FLAGS="$NDKF"  TARGET_SYS=LINUX
cp src/libluajit.a ../android/armv7-a/libluajit.a

cd ..
$GCC -fPIC lua_wrap.c pb.c $NDKF -o ./Plugins/Android/libs/armeabi-v7a/libulua.so -shared -Iluajit/src -I$CPPDIR -Wl,--whole-archive android/armv7-a/libluajit.a -Wl,--no-whole-archive -L$LIBDIR -static-libgcc -static-libstdc++