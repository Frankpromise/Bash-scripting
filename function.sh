# checking if a file exist or not using functions

#!/bin/bash
# a function that tells the user to give an argument if none is given
usage() {
  echo "You need to provide an argument"
  echo "usage: $0 file_name"
}

# checks if file exist
is_file_exist() {
    local file="$1"
    [[ -f "$file" ]] && return 0 || return 1
}

# check if user has given any argument

[[ $# -eq 0 ]] && usage

if ( is_file_exist "$1")
then
  echo "file found"
else
  echo "File found"

fi