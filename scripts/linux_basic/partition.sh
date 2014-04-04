#!/bin/sh
if [ ! -e ~/ERROR ]; then

	sudo parted -a optimal /dev/sda --script -- mklabel msdos
	#sudo parted -a optimal /dev/sda --script -- mklabel gpt

	sudo parted -a optimal /dev/sda --script -- unit mib

	sudo parted -a optimal /dev/sda --script -- mkpart primary 1 129
	#sudo parted -a optimal /dev/sda --script -- name 1 boot
	sudo parted -a optimal /dev/sda --script -- set 1 boot on

	sudo parted -a optimal /dev/sda --script -- mkpart primary 129 1153
	#sudo parted -a optimal /dev/sda --script -- name 2 swap

	sudo parted -a optimal /dev/sda --script -- mkpart primary 1153 -1
	#sudo parted -a optimal /dev/sda --script -- name 3 rootfs

fi

