#!/bin/bash
#
# check for non-existing file, exit status will be 2
#
ls somefile
echo "status: $?"

# create file, and do again, exit status will be 0
touch somefile
ls somefile
echo "status: $?"
