#!/bin/bash
###############################################################################
#
# Kernel Build Script
#
###############################################################################
# 2016-12-15 mifl         : modified to generate a flashable boot.img
# 2011-10-24 effectivesky : modified
# 2010-12-29 allydrop     : created
###############################################################################

###############################################################################
# Set variables
###############################################################################
BUILD_KERNEL_OUT_DIR=obj
BUILD_KERNEL_OUT_SUBDIR=KERNEL_OBJ
BUILD_JOB_NUMBER=`grep processor /proc/cpuinfo | wc -l`
BUILD_KERNEL_LOG=kernel_log.txt

###############################################################################
# Set toolchain
###############################################################################

export ARCH=arm
export PATH=$(pwd)/../../../prebuilts/gcc/linux-x86/arm/arm-eabi-4.7/bin:$PATH
export CROSS_COMPILE=arm-eabi-

###############################################################################
# Set defconfig
###############################################################################

DEFCONFIG_FILE=$1
if [ ! -e arch/arm/configs/$DEFCONFIG_FILE ]; then
	echo "No such file : arch/arm/configs/$DEFCONFIG_FILE"
	exit -1
fi

###############################################################################
# Build kernel
###############################################################################

mkdir -p ./$BUILD_KERNEL_OUT_DIR/$BUILD_KERNEL_OUT_SUBDIR/
make ARCH=arm O=./$BUILD_KERNEL_OUT_DIR/$BUILD_KERNEL_OUT_SUBDIR/ ${DEFCONFIG_FILE}
make -j$BUILD_JOB_NUMBER ARCH=arm O=./$BUILD_KERNEL_OUT_DIR/$BUILD_KERNEL_OUT_SUBDIR/ 2>&1 | tee $BUILD_KERNEL_LOG

###############################################################################
# Set mkbootimg dir
###############################################################################

if [ "$DEFCONFIG_FILE" = "ef65s_defconfig" ]; then
	MKBOOTIMGDIR=ef65s
else
	MKBOOTIMGDIR= ""
fi

###############################################################################
# Copy Kernel Image
###############################################################################

if [ -f ./$BUILD_KERNEL_OUT_DIR/$BUILD_KERNEL_OUT_SUBDIR/arch/arm/boot/zImage ]; then
	if [ "$MKBOOTIMGDIR" != "" ]; then
		cp -f ./$BUILD_KERNEL_OUT_DIR/$BUILD_KERNEL_OUT_SUBDIR/arch/arm/boot/zImage ./mkbootimg/${MKBOOTIMGDIR}
	else
		cp -f ./$BUILD_KERNEL_OUT_DIR/$BUILD_KERNEL_OUT_SUBDIR/arch/arm/boot/zImage ./
	fi
fi

##############################################################################
# Make BootImage
##############################################################################

# Prepare Device Tree Image (dt.img)
if [ "$MKBOOTIMGDIR" != "" ]; then
	pushd ./mkbootimg/${MKBOOTIMGDIR} > /dev/null
	./makedtimg.sh
	popd > /dev/null
fi

# Assembling the boot.img
if [ "$MKBOOTIMGDIR" != "" ]; then
	pushd ./mkbootimg/${MKBOOTIMGDIR} > /dev/null
	./makebootimg.sh
	popd > /dev/null
fi
