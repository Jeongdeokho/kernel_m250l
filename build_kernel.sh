#!/bin/bash
kernel=`readlink -f .`
cd
home=`readlink -f .`
cd $kernel
RoyalWolf=$home/rw
ramdisk=$RoyalWolf/ramdisk_jb/cwmjb
toolchain=$home/toolchain/linaro_4.8.3/bin/arm-gnueabi- # linaro gcc 4.8.3
defconfig_name=m250l-jb_defconfig
export ARCH=arm
export USE_SEC_FIPS_MODE=true
export CROSS_COMPILE=$toolchain
rm -rf pack out $ramdisk/lib/modules/*
unzip pack.zip
mkdir out
mv .git git
make $defconfig_name
make mrproper
make $defconfig_name
make -j16 CONFIG_INITRAMFS_SOURCE="$ramdisk"
find . -name "*.ko" -exec mv {} $ramdisk/lib/modules/ \;
make clean
make -j16 CONFIG_INITRAMFS_SOURCE="$ramdisk"
cp ./arch/arm/boot/zImage ./pack/boot/
cd $kernel/pack
zip -r ../out/M250L_JB.$(date -u +%m)-$(date -u +%d).zip ./
cd $kernel
make mrproper
mv git .git
touch $ramdisk/lib/modules/empty
