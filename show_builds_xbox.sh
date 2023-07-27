#!/bin/bash
#setup
address="10.10.10.160";


#logic
xbapp -x $address list | grep "FrozenDistrict.HouseFlipper_5"
xbapp -x $address listDLC | grep "FrozenDistrict" 

echo "Script done. . . Press enter to exit"
read x