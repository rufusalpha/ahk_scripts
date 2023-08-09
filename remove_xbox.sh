#!/bin/bash

#setup
address="";
things="";

#init
if [ ! -f "output.cfg" ]; then
    address="10.10.10.160";
else
    address=$(head -n 1 output.cfg);
	flag=true;

	while IFS= read -r line; do
		if [ $flag == true ]; then
			address=$line;
			flag=false;
		else
			things+=($line);
		fi 
	done < output.cfg
fi

echo -n "Enter ip address (empty for default: $address): " 
read x;

if [[ $x != "" ]]; then
    address=$x;
fi

#logic

echo "Do you want to delete all builds? (y/n)";
read x;

if [ $x == "y" ]; then
	x="";
	echo "Are you absolutely sure? (y/n) ";
	read x;
	
	if [ $x == "y" ]; then

		for i in ${things[@]}; do
			echo "   "$i;
			xbapp -x $address uninstall $i;
		done
	fi
fi




#ending
echo $address > output.cfg;
echo "Script done. . . Press enter to exit";
read x;

