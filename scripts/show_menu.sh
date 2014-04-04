#!/bin/sh
options=""

if [ $INSTALL_ERROR = 0 ]; then
	dialog  --title "$TITLE" --menu "Do you want to install a safe or vulnerable system? " 30 40 10 1 "Safe (For workstations)" 2 "Vulnerable (For Pen Testing)" 3 "Drop to command prompt" 4 "Cancel the install" 2> ./type_result

	os_type=$(cat ./type_result);
	rm ./type_result

	os_type_file=""
	cancel=0

	if [ "$os_type" = "1" ]; then
		tftp -g 192.168.1.10 -r images.lst
		os_type_file="images.lst"
	elif [ "$os_type" = "2" ]; then
		tftp -g 192.168.1.10 -r images-vuln.lst
		os_type_file="images-vuln.lst"
	elif [ "$os_type" = "3" ]; then
		cancel=1
		/bin/sh
		echo "Finishing shell, rebooting"
		sleep 1;
		sudo reboot;
	else
		clear
		echo "Install canceled, rebooting"
		sleep 2;
		sudo reboot;
	fi

	# Parse the given file
	while read line; do
		line_arch=$(echo $line | cut -d ":" -f1)

		add=0

		# Check if valid arch in image file
		if [ "$line_arch" = "x64" ] || [ "$line_arch" = "x32" ]; then
		
			add=0

			if [ "$INSTALL_ARCH" = "x64" ] ; then
				# 64 bit arch will support 32 and 64 bit operating systems
				add=1
			elif [ "$INSTALL_ARCH" = "x32" ] && [ "$line_arch" = "x32" ]; then
				add=1
			fi

			if [ $add = 1 ]; then
				# add to list
				line_os=$(echo $line | cut -d ":" -f2)
				line_id=$(echo $line | cut -d ":" -f3)
				line_name=$(echo $line | cut -d ":" -f4)


				option_line="$line_id '$line_name ($line_os)'"
				options="$options $option_line"
			fi
		else
			echo "Nothing"
		fi

	done < $os_type_file

	if [ "$os_type_file" = "images-vuln.lst" ]; then
		message="Select the vulnerable OS to install: "
	else
		message="Select the safe OS to install: "
	fi

	eval "dialog --menu '$message' 30 30 20 $options cancel 'Cancel the install' 2> image_id.value"
	image_id=$(cat ./image_id.value);
	
	# Get settings for image

	while read line; do
		image_name=$(echo $line | cut -d ":" -f3)

		if [ "$image_name" = "$image_id" ]; then
			temp=$(echo $line | cut -d ":" -f5) 
			echo "$temp" > partition_type.value
			temp=$(echo $line | cut -d ":" -f4) 
			echo "$temp" > image_name.value
			temp=$(echo $line | cut -d ":" -f2) 
			echo "$temp" > image_type.value
			break
		fi

	done < $os_type_file

fi


