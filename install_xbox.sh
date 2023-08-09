#!/bin/bash

#setup
address="";

#init
if [ ! -f "output.cfg" ]; then
    address="10.10.10.160";
else
    address=$(head -n 1 output.cfg);
fi

echo -n "Enter ip address (empty for default: $address): " 
read x;

if [[ $x != "" ]]; then
    address=$x;
fi

#echo $address;

if [ ! -d "install" ]; then
    mkdir install;
    touch install/place_files_here;
    echo "no install folder was found -> created -> place build files inside";
    explorer install
else
    #check
    echo "List files for installation";
    for i in $(ls install); do
        if [[ $i == "place_files_here" ]]; then
            rm install/place_files_here;
            continue;
        fi
        echo "   "$i
    done

    #process
    echo "Do you want to install? (y/n)";
    read x;

    echo "Do you want to remove after installation? (y/n)";
    read del;

    if [ $x == "y" ]; then
        for i in $(ls install); do
            if [[ $i == "place_files_here" ]]; then
                rm install/place_files_here;
                continue;
            fi
            
            xbapp -x $address install install/$i;

            if [[ $del == "y" ]]; then
                rm install/$i;
            fi
        done
    fi
fi

#ending
echo $address > output.cfg;

echo "Script done. . . Press enter to exit";
read x;


