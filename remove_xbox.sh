#!/bin/bash

#setup
things=("FrozenDistrict.HouseFlipper_5.1.1.0_neutral__zytsvtd1jsvc4" 
"FrozenDistrict.HouseFlipper-Pets_5.1.1.0_neutral__kqzqk4xtpwaqc" 
"FrozenDistrict.HouseFlipper-Luxury_5.1.1.0_neutral__kqzqk4xtpwaqc" 
"FrozenDistrict.HouseFlipper-Garden_5.1.1.0_neutral__kqzqk4xtpwaqc");

address="10.10.10.160";

#logic

echo "Do you want to delete all builds? (y/n) ";
read x

if [ $x == "y" ]; then
	x="";
	echo "Are you absolutely sure? (y/n) "
	read x
	
	if [ $x == "y" ]; then

		for i in ${things[@]}; do
			echo $i;
			xbapp -x $address uninstall $i;
		done
	fi
fi

echo "Script done. . . Press enter to exit";
read x;

