#!/bin/sh
if [ ! -e ~/ERROR ]; then
	sudo sed -i "s_UUID=[-0-9a-zA-Z]*[ ]*/[ ]_/dev/sda3     /_" /mnt/install/etc/fstab 
	sudo sed -i "s_UUID=[-0-9a-zA-Z]*[ ]*/boot[ ]_/dev/sda1     /boot_" /mnt/install/etc/fstab
	sudo sed -i "s_UUID=[-0-9a-zA-Z]*[ ]*swap[ ]_/dev/sda2     swap_" /mnt/install/etc/fstab
fi



