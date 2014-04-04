#!/bin/sh
if [ ! -e ~/ERROR ]; then
	sudo mkdir /mnt/install
	sudo mount /dev/sda3 /mnt/install

	sudo mkdir /mnt/install/boot
	sudo mount /dev/sda1 /mnt/install/boot

	sudo swapon /dev/sda2
fi
