#!/bin/bash
# Compare two stings using the [] operators
#
echo Give two strings to compare ...
read str1 str2
echo str1="$str1", str2="$str2"

echo Testing with double brackets, no quotes
if [[ $str1 = $str2 ]] ; then
	echo "These strings are identical"
else
	echo "These strings are not the same"
fi

echo Testing with single brackets, with quotes
if [ "$str1" = "$str2" ] ; then
	echo "These strings are identical"
else
	echo "These strings are not the same"
fi

echo Testing with single brackets, no quotes
if [ $str1 = $str2 ] ; then
	echo "These strings are identical"
else
	echo "These strings are not the same"
fi
# end of script

