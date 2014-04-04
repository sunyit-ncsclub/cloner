#!/bin/sh

# Verify there has been no errors
if [ ! -e ~/ERROR ]; then
	OLD_PWD=pwd;
	cd /mnt/install

	OKAY=0

	#Now retrieve the image

	if [ -n "$IMAGE_NAME" ]; then
		while [ $OKAY = 0 ]; do


			echo "Downloading..."
			# Get the image file
			sudo tftp -g 192.168.1.10 -r /images/$IMAGE_ID.tar.gz
			sudo tftp -g 192.168.1.10 -r /images/$IMAGE_ID.md5


			MD5_REMOTE=$(cat $IMAGE_ID.md5)
			MD5_LOCAL=$(md5sum $IMAGE_ID.tar.gz)

			if [ "$MD5_REMOTE" = "$MD5_LOCAL" ]; then
				OKAY=1
			else
				echo "Files did not download properly, trying again" >> ~/cloner_error.log
			fi

		done
	else
		echo "No image has been set, Aborting!"  >> ~/cloner_error.log
		touch ~/ERROR
	fi
	cd "$OLD_PWD"

fi




