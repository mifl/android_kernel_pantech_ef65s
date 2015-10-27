#!/bin/sh

./mkbootimg --base 0x00000000 --kernel zImage --ramdisk_offset 0x01000000 --tags_offset 0x00000100 --pagesize 2048 --cmdline "console=NULL,115200,n8 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37 ehci-hcd.park=3 vmalloc=260M loglevel=0" --ramdisk initrd.img --dt dt.img -o boot.img
