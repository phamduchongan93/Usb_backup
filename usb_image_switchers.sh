#!/bin/bash
# Description: Script to produce an image of the current attached usb to store it as backup.
# finding the usb device
# sudo checker
# 
# 1. check the user
# 2. find the name of the usb
# 3. verify with user that they want to change the script.


if [ "`whoami`" != root ]
then
	echo "You need root privellege to run this script. You may do so by typing sudo prior to the the command" 
	exit 1
fi;

# compressing the image
function compressing() {
if [ -w "$1" ]
then
#	gzip $1
fi;
}

usb_name="`lsblk -o NAME,TRAN | grep -i usb | cut -f 1 -d ' '`" # get the name of usb
echo " Deploying usb wiping sequence. You can't postpone this process and will loose your usb data." 
while true;
do
	read -p "Do you want to perform this task? (y/n)" choice;
	case "$choice" in	
	[Yy])
		echo -e "\tYou picked $choice.";
		time dd if="/dev/$usb_name" of="usb_images.img" bs=4M status=progress;
		echo " Proceeding compression process ";

		tar -czvf "$1.tgz" "$1";
	#	compressing 'usb_images.img';
		break;
		;;
	[Nn])
		echo -e "\tYou pick $choice"; break;
		;;
	*)
		echo -e "\t You choice is not valid, Please type in y or n "
		;;
	esac
done


