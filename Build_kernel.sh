#!/bin/bash

if [ -d include/config ];
then
    echo "Find config,will remove it"
	rm -rf include/config
else
	echo "No Config,good."
fi

export PATH=$PATH:$(pwd)/aarch64-linux-android-4.9-master/bin
export CROSS_COMPILE=aarch64-linux-android-

export GCC_COLORS=auto
export ARCH=arm64
if [ ! -d "out" ];
then
	mkdir out
fi

# 提示用户选择选项
echo "请选择一个选项："
echo "1. 设置defconfig参数为 merge_hi6250_defconfig"
echo "2. 设置defconfig参数为 maimang6_defconfig"
echo "3. 设置defconfig参数为 maimang6_ksu_defconfig"
echo "请输入数字"

# 读取用户输入的选项
read choice

# 根据用户选择设置defconfig参数
case $choice in
  1)
    defconfig="merge_hi6250_defconfig"
    ;;
  *)
    echo "无效的选项"
    exit 1
    ;;
esac

# 输出所选的defconfig参数
echo "已选择的defconfig参数为: $defconfig"


make ARCH=arm64 O=out ${defconfig}
make ARCH=arm64 O=out -j64 2>&1 | tee kernel_build.log
