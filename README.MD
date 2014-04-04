# NCS Club Cloner

This is a system built to all users to select an operating system image to install to a phyiscal device.

An 'image' is the tarred and gzipped (tar.gz) root filesystem

Significant documentation will be forthcoming.

## 'tftp' folder

This holds the files that will be placed in the TFTP server's root folder.

## 'images' folder

Holds images, and their 

## 'scripts' Folder

This holds the scripts downloaded by the Tiny Core. They do the actual partitioning and installation.

The root scripts directory is for the cloner's scripts. However, directories under scripts are used to hold partitioning and installation schemes. linux_basic is a basic linux scheme, msdos table, three partitions (1 root, 1 boot, 1 swap), manages legacy and grub2 installation.

If you want to make your own, these are the required scripts as the main script, cloner_script.sh, calls these in this order.

1. partition.sh - Put partitioning shell commands here 
2. fs_config.sh - Put filesystem shell commands here
3. mounting.sh - Put mounting commands here
4. install_bl.sh - Put bootloader installation commands here, this happens after the files are extracted to the drive
5. custom.sh - Put othe necessary commmands here, like changing drive mappings, etc in the installed OS, this happens after the files are extracted to the drive

## The images.lst/images-vuln.lst file

This is the format of this file:

ARCH:OS_TYPE:IMAGE_ID:IMAGE_NAME:PARTITIONING_TYPE

ARCH - The architecture of the image, this is either "x32" or "x64"
OS_TYPE - The OS type, either "Linux" or "Windows"
IMAGE_ID - The id of the name, this is to be the name of the file in the 'images' folder
IMAGE_NAME - The name of the image, this is what is displayed to the user
PARTITIONING_TYPE - The partitioning format to use. Indicates the folder in the scripts folder that is selected and used

images.lst is for safe images (for general usage)
images-vuln.lst is for vulnerable images (for pentesting)


