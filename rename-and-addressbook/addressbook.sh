#!/bin/bash

addressbook=addressbook.txt 



new () {
    echo "$1 " "$2" >> "$addressbook" ;
}

list () {
    if [ -s "$addressbook" ] 
    then
        cat "$addressbook"
    
    else
        #Tell user the file addressbook is empty  
        echo "Addressbook is empty."
    fi ;
}



remove () {
    #Delete the line(s) that matche(s) the name given to the function and cretae a new file with the result 
    sed "/$1/d" ./"$addressbook" >> temp.txt
    
    #replace the addressbook with the resulting new file 
    mv temp.txt $addressbook ;
}


clear () {
    #Delete addressbook
    > "$addressbook" ;
}


lookup () {
    #Display emails associated with the name given
    grep "$1" "$addressbook" | awk '{print $3}'; 
}

"$@"


