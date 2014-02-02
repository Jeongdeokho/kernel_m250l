kernel=`readlink -f .`
cd
home=`readlink -f .`
cd $kernel
RoyalWolf=$home/rw
ramdisk=$RoyalWolf/ramdisk_jb/cwmjb
toolchain=$home/toolchain/linaro_4.8/bin/arm-linux-gnueabihf- # linaro gcc 4.8.2
#toolchain=$home/toolchain/linaro_4.8.3/bin/arm-gnueabi- # linaro gcc 4.8.3
defconfig_name=m250l-jb_defconfig
export ARCH=arm
export USE_SEC_FIPS_MODE=true
export CROSS_COMPILE=$toolchain
rm -rf pack out $ramdisk/lib/modules/*
make $defconfig_name
make mrproper
find . -name "*.c" -exec chmod 0644 {} \;
find . -name "*.h" -exec chmod 0644 {} \;
