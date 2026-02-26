#!/bin/bash
# check for existing file
echo "Give a file name to check if it exists"
read filename
#
echo "Checking ..."
if [[ -f $filename ]] ; then
	echo "$filename exist"
else
	echo "$filename does not exists!"
fi
# end of script

