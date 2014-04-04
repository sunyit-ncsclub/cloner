#!/bin/sh
if [ ! -e ~/ERROR ]; then
	sudo mkfs.ext2 /dev/sda1
	sudo mkfs.ext4 /dev/sda3

	sudo mkswap /dev/sda2
fi
