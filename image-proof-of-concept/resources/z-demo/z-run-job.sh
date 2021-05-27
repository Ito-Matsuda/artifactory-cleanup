#!/bin/bash

###############################################
# Purpose: Run Scripts in sequence
#####
# Arguments:
# $1 'DELETE' to trigger an actual run where the 'delete' happens
#####
# TODO: Change the URL, confirm credentials
###############################################

# All these scripts would be copied to the ggeneric landing area of the docker container
echo "Starting Artifactory cleanup"

# for testing purposes 
passwd=!

# Retrieve old images
echo "Retrieving Old images------------"
./1-get-old-images.sh $passwd

# Retrieve images in use in the cluster
echo "Getting images in use by the cluster------------"
./2-get-inuse-images.sh

# Get a list of unused images by comparing the old and the images in use
echo "Comparing old images with those in use------------"
./3-remove-in-use-from-list.sh

# Call a delete on those images unused old images
echo "Performing $1 on the unused old images------------"
./x-delete-images.sh 3-to-delete.txt $1

# Get a list of vulnerable images
echo "Getting a list of vulnerable images------------"
./4-get-violations.sh $passwd
printf "k8scc01covidacr.azurecr.io/jupyterlab-cpu/dee04931\n" >> 4C-formatted-impacted-artifacts.txt

# Compare the vulnerable images and notebook images and get the intersection of the two.
echo "Finding an intersection between vulnerable and used notebook images------------"
./5-make-comparisons.sh

# If they exist, get a list of suitable images to update to.
echo "Finding replacement notebook images------------"
./6-get-replacement-images.sh

# Patch or delete the notebook depending on if there is an image to update to.
echo "Patching or deleting notebook images------------"
./7-patch-or-delete-nb.sh

# Delete the vulnerable images (these will contain more than just notebook images)
# Should confirm if this is ok. 
# If we want to can set up a watch to just look at our own + user images (and not care for platform images)

# Note that this is the one we formatted without the default
# Still need to determine if this will be necessary or can use the other one. 
# Note that 4X-impacted artifacts is modified in step 5 '/' -> ';' to compare easily.
# Change back to slash to have the location now.
echo "Deleting vulnerable images from artifactory------------"
sed -i 's/;/\//g' 4C-formatted-impacted-artifacts.txt 
./x-delete-images.sh 4C-formatted-impacted-artifacts.txt $1

echo "Ending Artifactory cleanup"
