#!/bin/bash

set -e

if [ ! -d out ]; then
	mkdir out
fi

TOOLCHAIN_PATH=/home/Vevelo/firemax13/aarch64-linux-android

export CROSS_COMPILE=$TOOLCHAIN_PATH/bin/aarch64-linux-android-
export ARCH=arm64

KERNEL_MAKE_ENV="DTC_EXT=$(pwd)/tools/dtc"

make -C $(pwd) O=$(pwd)/out ARCH=arm64 $KERNEL_MAKE_ENV KCFLAGS=-mno-android a20s_eur_open_defconfig
make -j8 -C $(pwd) O=$(pwd)/out ARCH=arm64 $KERNEL_MAKE_ENV KCFLAGS=-mno-android

tools/mkdtimg create out/arch/arm64/boot/dtbo.img --page_size=2048 $(find out -name "*.dtbo")
