#!/bin/bash

find . -type f > names.lst

while read name
do
    bn="$( basename "$name" )"
    name2="$( grep "$bn" names.lst | grep -v "$name" )"
    if [ "$name2" != "" ]
    then
	echo "$name"
	echo "$name2"
    fi
done < names.lst
