#!/bin/bash

# TODO: add prompt and -f option

if [ "$1" == "-h" ] ; then
    echo "Help: provide git root directory as parameter for git repo to be optimized"
    exit
fi

if [ -z $1 ] ; then
    echo "Error: provide root directory for git repo to be optimized"
    exit
fi

if [[ ! -d "$1" ]] ; then
    echo "Error: path provided is not directory"
    exit
fi

echo About to execute git_optimize_once.sh on $1 in 5 seconds
sleep 5s
find $1 -name .git -type d -execdir ~/trident-developer-tools/git_optimize_once.sh {} ';'

echo $1 is now optimized for performance
