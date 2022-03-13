#!/bin/bash

###############################################
# Purpose: Compare images on cluster to XRAY hits
#####
# Actions: Compare results of C script and A script to get overlaps and write to a file
# Requires: a-uniqe-nb-images.txt (uniqd notebook img in cluster),
## c-formatted-impacted-artifacts.txt (uniq'd vulnerable images from XRAY)
# Extra Info
####
###############################################

# Replace any : with / and write to a different file k8sc.io/jupyterlab-cpu/16b01881
# Will then be changed in next step to be uniform.
sed "s/:/\//" a-uniqe-nb-images.txt >> d-notebook-artifactory-comp.txt

# Avoid any escaping problems by going from `/` --> `;`
# So like k8.io;jupyterlab-cpu;16b01881
sed -i 's/\//;/g' c-formatted-impacted-artifacts.txt
# sed -i 's/\//;/g' d-notebook-artifactory-comp.txt #useless

# Avoid escaping problems and match up to impacted artifacts
sed 's/\//;/g' d-notebook-artifactory-comp.txt |
while read -r imageCheck
do
  # extract the image from the file, trim the quotes, and replace the : with a ;
  # Look for the image in the imapacted artifacts and if found print the line to the list. 
  if grep -Fxq "$imageCheck" c-formatted-impacted-artifacts.txt
  then
     echo $imageCheck >> d-user-items.txt
  fi
done
