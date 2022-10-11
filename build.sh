#!/bin/bash

# toolchain path
Toolchain=$(cd ../openwrt*/staging_dir/toolchain-mipsel*/bin; pwd)'/mipsel-openwrt-linux-'
Staging=${Toolchain%/toolchain-*}

echo "CROSS_COMPILE=${Toolchain}"
echo "STAGING_DIR=${Toolchain%/toolchain-*}"
cd $(dirname "$0")

# add board name here
Boards=( \
	)

if [ ! -d "./bin" ]; then
	mkdir ./bin
fi

for Board in ${Boards[@]}
do
	echo "Build ${Board}"
	make clean
	make ${Board}_defconfig
	make CROSS_COMPILE=${Toolchain} STAGING_DIR=${Staging}
	if [ ! -d "./bin/$Board" ]; then
		mkdir ./bin/$Board
	else
		rm ./bin/$Board/*
	fi
	# mv ./u-boot.img ./bin/$Board/u-boot.img
	mv ./u-boot-mt7621.bin ./bin/$Board/u-boot-mt7621.bin
done
