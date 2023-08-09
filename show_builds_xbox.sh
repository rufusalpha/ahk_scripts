#!/bin/bash

#setup
address="";

#init
if [ ! -f "output.cfg" ]; then
    address="10.10.10.160";
else
    address=$(head -n 1 output.cfg);
fi

#input
echo -n "Enter ip address (empty for default: $address): " ;
read x;

if [[ $x != "" ]]; then
    address=$x;
fi

#logic
echo $address > output.cfg;

xbapp -x $address list | grep "FrozenDistrict.HouseFlipper_5" | sed 's/ //g' >> output.cfg;
xbapp -x $address listDLC | grep "FrozenDistrict" | sed 's/ //g' >> output.cfg;

xbapp -x $address list | grep "FrozenDistrict.HouseFlipper_5"
xbapp -x $address listDLC | grep "FrozenDistrict" 

#ending
echo "Script done. . . Press enter to exit";
read x;