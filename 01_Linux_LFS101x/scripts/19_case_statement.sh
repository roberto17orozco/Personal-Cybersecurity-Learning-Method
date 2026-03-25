#!/bin/bash
echo "Do you want to destroy your entire filesystem?"
read response

# case statement input
case "$response" in
    "yes")          echo "I hope you know what you are doing!";;
    "no")           echo "You have some common sense!";;
    "y" | "Y" | "YES")      echo "I hope you know what you are doing!"
                            echo "I am supposed to type: rm -rf /" ;
                            echo "But I am not going to let you commit suicide" ;;
    "n" | "N" | "NO")       echo "You have some common sense!" ;;
    *)                      echo "You have to give an answer!" ;;
esac
