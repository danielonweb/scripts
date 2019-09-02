#!/bin/bash

echo working on - `pwd`

echo Give you 3 seconds before starting to clean this git repo
sleep 3s 

echo "Running garbage collecting - git gc --aggressive"
git gc --aggressive
echo "Prunning stable tracking branches - git remote prune origin"
git remote prune origin

echo done
