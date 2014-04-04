#!/bin/sh

if [ ! -e ~/ERROR ]; then
	OLD_PWD=pwd;
	cd /mnt/install

	sudo tar -xzf $IMAGE_ID.tar.gz 	

	rm ./$IMAGE_ID.tar.gz

	cd "$OLD_PWD"

fi
