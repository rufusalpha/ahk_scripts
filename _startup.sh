#! /bin/bash

#########################################################################
#  wpisz poniższym arrayu repos ścieżkę bezwzględną w formacie git bash #
#  będzie ona wyglądać mniej więcej tak jak poniżej						#
#  		/litera_dysku/folder/HouseFlipperRelease						#
#  najlepiej wejść w katalog gdzie jest repo, otworzyć git bash,		#
#  wpisać komendę "pwd" i skopiować w ścieżkę z konsoli					#
#  WIELKOŚĆ LITER MA ZNACZENIE!!!!!!!									#
#########################################################################

repos=(
	"/c/HF-Repo/HouseFlipperRelease/"
	"/e/HF-Repo/HouseFlipperRelease/"
)

echo "Rufus's Daily Startup Script :) "
echo ''
read -n 1 -s -p "press any key to continue . . ."
echo ''

for str in ${repos[@]}
do
	if cd $str ; then
		pwd
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