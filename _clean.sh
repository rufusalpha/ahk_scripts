#! /bin/bash

echo -n "Rufus's Clean-up Script :) "

for V in 1 2 3 4 5
do
    sleep 0.2s
    echo -n ' . '
done
echo ''


cd /c/HF-Repo/HouseFlipperRelease/
pwd
git status
git restore .
git clean -fd

echo ''
echo ''
cd /e/HF-Repo/HouseFlipperRelease/
pwd
git status
git restore .
git clean -fd

echo -n 'Program terminated '
for V in 1 2 3 4 5
do
    sleep 0.2s
    echo -n ' . '
done
echo ''


