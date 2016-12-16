#!/bin/bash
###############################################################################
#
# Kernel Clean Script
#
###############################################################################
# 2016-12-15 mifl         : modified for clean mkbootimg dir
# 2011-10-24 effectivesky : modified
# 2010-12-29 allydrop     : created
###############################################################################

###############################################################################
# Set variables
###############################################################################
BUILD_KERNEL_OUT_DIR=obj
BUILD_KERNEL_OUT_SUBDIR=KERNEL_OBJ
BUILD_KERNEL_LOG=kernel_log.txt

###############################################################################
# Set toolchain
###############################################################################

export ARCH=arm
export PATH=$(pwd)/../../../prebuilts/gcc/linux-x86/arm/arm-eabi-4.7/bin:$PATH
export CROSS_COMPILE=arm-eabi-

###############################################################################
# Clean: boot.img, dt.img, zImage, log file and obj dir
###############################################################################

make mrproper
make O=./$BUILD_KERNEL_OUT_DIR/$BUILD_KERNEL_OUT_SUBDIR/ clean

if [ -f ./mkbootimg/*/boot.img ]; then
	rm ./mkbootimg/*/boot.img
fi

if [ -f ./mkbootimg/*/zImage ]; then
	rm ./mkbootimg/*/zImage
fi

if [ -f ./mkbootimg/*/dt.img ]; then
	rm ./mkbootimg/*/dt.img
fi

if [ -f ./zImage ]; then
	rm ./zImage
fi

if [ -d ./$BUILD_KERNEL_OUT_DIR/ ]; then
	rm -r ./$BUILD_KERNEL_OUT_DIR/
fi

if [ -f ./$BUILD_KERNEL_LOG ]; then
	rm ./$BUILD_KERNEL_LOG
fi
