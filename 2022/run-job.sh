#!/bin/bash

###############################################
# Purpose: Run Scripts in sequence
#####
# Arguments:
# $1 'DELETE' to trigger an actual run where the 'delete' happens
#####
# TODO: Change the URL, confirm credentials
###############################################

# All these scripts would be copied to the generic landing area of the docker container
echo "Starting Artifactory cleanup\n"

echo "Obtaining a list of notebook images being used in the cluster------------\n"
./a-get-list-of-notebook-img.sh

echo "Initiating Pulls------------\n"
./b-pull.sh

echo "Getting a list of vulnerabilities------------\n"
./c-xray-get-vulnerabilities.sh

echo "Comparing and outputting a list of vulnerable images in the cluster------------\n"
./d-compare.sh


echo "Ending Artifactory cleanup"
