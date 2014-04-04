#!/bin/sh

#======================================================
#
# SUNYIT NCS Club PXE OS Installer
#
# Originally built by Jacob Hartman
# Idea from SUNYIT CS Department and Joseph Vandermaas
#
# Docs at http://ncsclub.sunyit.edu/wiki/Cloner
#
# Overly commented for posterity's sake
#
#======================================================

# Setup the enviroment variables
export INSTALL_ERROR=0;
export IMAGE_ID='';
export PARTITION_TYPE='';
export IMAGE_NAME=''
export IMAGE_TYPE=''
export INSTALL_ARCH='';

# Get the arch of the current computer
get_arch=$(grep "flags" /proc/cpuinfo | grep " lm ")
if [ "$get_arch" != "" ]; then
	INSTALL_ARCH="x64";
else
	INSTALL_ARCH="x32";
fi


# Check for error flag (~/ERROR)
if [ -e ~/ERROR ]; then
	rm -rf ~/ERROR
fi

# Parse the image list, and display dialog
./show_menu.sh

IMAGE_ID=$(cat ./image_id.value);
PARTITION_TYPE=$(cat ./partition_type.value);
IMAGE_TYPE=$(cat ./image_type.value);
IMAGE_NAME=$(cat ./image_name.value);


# Should do a verify of files here
echo "$PARTITION_TYPE $IMAGE_TYPE $IMAGE_NAME"
echo "----"

if [ "$PARTITION_TYPE" != "" ]; then
	
	chmod +x ./$PARTITION_TYPE/*.sh

	echo "!- Partitioning drive"
	# Partition the drives
	./$PARTITION_TYPE/partition.sh


	echo "!- Configuring filesystems"
	# Configure the filesystems
	./$PARTITION_TYPE/fs_config.sh


	echo "!- Mounting filesystems"
	# Mount everything
	./$PARTITION_TYPE/mounting.sh

	echo "!- Downloading file to drive"
	# Download the files
	./download.sh


	echo "!- Unpacking archive to drive"
	# Download the files
	./unpack.sh


	echo "!- Installing Bootloader"
	# Install the bootloader (GRUB if linux, etc.)
	./$PARTITION_TYPE/install_bl.sh


	echo "!- Finishing up"
	# Make other micellaneous changes
	./$PARTITION_TYPE/custom.sh

	
	if [ -e ~/ERROR ]; then
		echo "An error occured, please view ~/cloner_error.log for details"
	else
		# Install went well
		echo "Install completed successfully!"
	fi
else
	echo "No partitioning scheme has been selected"
fi
