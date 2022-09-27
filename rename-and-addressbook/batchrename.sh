#!/bin/bash

#Navigating into the directory
cd "$1" || return

# Renaming all *.dat to *.txt
for file in *."$2" ; 
do 
    mv -v "$file" "${file%."$2"}.$3"
done;

# Get the number of lines in ls which contain .txt (should be 26)
number=$(ls -lAh | grep -c .txt)
echo "the number of lines in tmp which contain .txt is $number" 