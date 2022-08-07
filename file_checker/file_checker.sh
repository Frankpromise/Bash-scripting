#!/bin/bash

if [ -f $file_name ]
then
     if [ -w $file_name ] 
     then
        echo "Type some text data. To quit press ctrl+c"
        cat >> $file_name
     else
       echo "$file_name do not have write permissions"
     fi
else
  echo "$file_name does not exist"
fi
