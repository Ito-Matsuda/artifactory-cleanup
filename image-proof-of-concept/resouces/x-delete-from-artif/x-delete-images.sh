#!/bin/sh

###############################################
# Purpose: Delete artifacts at a given folder path
#####
# Arguments:
# $1 A text file contianing the path's of artifacts to be deleted
## Expected input for this is to come from 
## 3-list-images to delete (old+unused)
## 4C-formatted-impacted artifacts
# $2 If not set to 'DELETE' then a dry-run is triggered. 
#####
# Action: Can be called twice, once after the old and unused images are found
# and again after the delete + email notifications have been sent
# Takes in a list of paths and deletes them from artifactory.
#####
# TODO: Change the URL, confirm credentials
###############################################

# This URL should be changed to ours
URL="https://testjosez.jfrog.io/artifactory"

cat $1 | 
while read -r line
do
  if [ "$2" = "DELETE" ]; then
    echo "DELETING..."
    #curl -u myuser:password! -X DELETE $URL"/"$line
  else 
    echo "Would delete-->"$URL"/"$line #>> x-dryrun-delete.txt
  fi
done