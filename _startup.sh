#! /bin/bash

#################################################################################
#		  	please enter your repos direct path in git bash format				#
#		  	it will look more or less like the one below 						#
#		  		/drive_letter/some/catalogs/HouseFlipperRelease					#
#  it's best to go into that catalog, enter 'pwd' command and copy it's result	#
#  					BASH IS CASE SENSITIVE!!!!!!!!								#
#################################################################################

repos=(
	"/c/HF-Repo/HouseFlipperRelease/"
	"/e/HF-Repo/HouseFlipperRelease/"
)

echo "Rufus's Daily Startup Script :) "
echo ''
read -n 1 -s -p "press any key to continue OR press c to perform cleanup  . . ." varset
echo ''

for str in ${repos[@]}
do
	if cd $str ; then
		pwd
		if [ "$varset" = 'c' ] ; then
			echo "cleaning . . ."
			git restore .
			git clean -fd
		fi

		git status
		git fetch
	else
		echo "repo "$str" error"
	fi
	echo ''
	echo ''
done

cd /d/Recordings
pwd
ls -al
rm -rf *.mkv

echo ''
read -n 1 -s -p "press any key to continue . . ."
echo ''