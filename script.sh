#!/bin/bash

#######################################################################################
#######################################################################################
### How to Configure																###
### in array named "paths" below you have to enter paths to your repository			###
###	every path must be separated by a SPACE or TAB character						###
### in gitbash form - i.e. paths=("/c/folder/target" /e/folder/otherTarget")		###
### IMPORTANT THING!!!																###
### IF path to your repo contains a SPACE, i.e, "/c/my repo" you HAVE TO change it	###
### no other way about it, if you leave it as is script can't target it correctly   ###
### as space is a array separator 													###
#######################################################################################
#######################################################################################

paths=("/c/HF-Repo/HouseFlipperRelease" "/e/HF-Repo/HouseFlipperRelease");

#######################################################################################
#######################################################################################

if [ $# == 1 ]; then
    if [ $1 == "c" ]; then
        cd ${paths[0]};
    elif [ $1 == "e" ]; then
        cd ${paths[1]}
    else 
        echo "Error - invalid argument";
    fi

    git rev-parse HEAD > commit_id.git;
else
    echo "Error - no argument path specified";
fi;