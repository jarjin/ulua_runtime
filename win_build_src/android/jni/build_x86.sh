rm ./libluajit.a
echo APP_ABI := x86>./Application.mk

NDK=D:/adt-bundle-windows/ndk-r8d
NFK=$NDK/toolchains/x86-4.7/prebuilt/windows/bin/i686-linux-android-

cd luajit/src
make clean
make HOST_CC="gcc -m32 -ffast-math -O3" \
	 CROSS=$NFK \
	 TARGET_SYS=Linux \
	 TARGET_FLAGS="--sysroot $NDK/platforms/android-14/arch-x86 -Wl,--fix-cortex-a8"
cp ./libluajit.a ../../libluajit.a

cd ../../../
ndk-build clean
ndk-build