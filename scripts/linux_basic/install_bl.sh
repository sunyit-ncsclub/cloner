if [ ! -e ~/ERROR ]; then
	if [ -e /mnt/install/boot/grub/menu.lst ]; then
		echo "Found legacy grub";
	
		echo "(hd0) /dev/sda" > devmap

		echo "root (hd0,0)" >> grub_script
		echo "setup (hd0)" >> grub_script
		echo "quit" >> grub_script

		sudo grub --device-map ./devmap --batch < grub_script

		sudo sed -i "s_root=UUID=[-0-9a-zA-Z]\{36\}_root=/dev/sda3_" /mnt/install/boot/grub/menu.lst

	elif [ -e /boot/grub/grub.cfg ]; then

		echo "Found grub2";
	
		sudo grub-install --boot-directory=/mnt/install/boot /dev/sda
	else

		echo "No grub found!" >> ~/cloner_error.log
		touch ~/ERROR
	fi

fi

