#!/bin/bash
# 1.- Prompt the user for a directory name and then creates it with mkdir.

echo "Give a directory name to create:"
read NEW_DIR

# Save original directory so we can return to it (could also just use pushd, popd)

ORIG_DIR=$(pwd)

# check to make sure it doesn't already exists!

[[ -d $NEW_DIR ]] && echo $NEW_DIR already exists, aborting && exit 1 
mkdir $NEW_DIR

# 2.- Changes to the new directory and prints out where it is using pwd.

cd $NEW_DIR
pwd

# 3.- Using touch, creates several empty files and runs ls to verify they are empty.

for n in 1 2 3 4 
do
	touch file$n
done

ls file?

# (Could have just done touch file1 file2 file3 file4, just want to show do loop!)

# 4.- Puts some content in them using echo and redirection.

for names in file?
do
	echo This file is named $names > $names
done


# 5.- Displays their content using cat

cat file?

# 6.- Says goodbye to the user 

cd $ORIG_DIR
echo "Goodbye My Friend!"
