#!/bin/sh

./1-get-old-images.sh
./2-process-jq-1.sh
./3-remove-in-use.sh
#some 4 here
#run a dry run
./5-delete-images.sh