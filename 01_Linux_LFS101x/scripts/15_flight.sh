#!/bin/bash

echo "Please specify Window, Middle or Aisle for your seat"
read CHOICE

if [ "$CHOICE" == Window ] ; then
	echo "you have a Window seat, 29A"
elif [ "$CHOICE" == Middle ] ; then
	echo "you have a Middle seat, 29B"
elif [ "$CHOICE" == Aisle ] ; then
	echo "you have an Aisle seat, 29C"
else
	echo $CHOICE is not a valid answer
	echo try again
fi
