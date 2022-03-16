#!/bin/bash

###############################################
# Purpose: Compare images on cluster to XRAY hits
#####
# Actions: Compare results of C script and A script to get overlaps and write to a file
# This file is a list of impacted user images which has CRITICAL un-ignored vulnerabilities.
# Will then be compared against in a-kubectl-notebook.
# Requires: a-uniqe-nb-images.txt (uniqd notebook img in cluster),
## c-formatted-impacted-artifacts.txt (uniq'd vulnerable images from XRAY)
# Extra Info
####
###############################################

# Replace any : with / and write to a different file k8sc.io/jupyterlab-cpu/16b01881
# Will then be changed in next step to be uniform.
sed "s/:/\//" a-uniqe-nb-images.txt > d-notebook-artifactory-comp.txt

# Avoid any escaping problems by going from `/` --> `;`
# So like k8.io;jupyterlab-cpu;16b01881
sed 's/\//;/g' c-formatted-impacted-artifacts.txt > d-formatted-impacted-artifacts.txt
sed -i 's/\//;/g' d-notebook-artifactory-comp.txt

# Need to format BOTH to get rid of the registry name. This is because for the remote-repository
# It may read k8s..-cache if the image has been cached and will thus not match on any of the pulled notebook images
sed -i 's/^[^;]*;//g' d-notebook-artifactory-comp.txt
sed -i 's/^[^;]*;//g' d-formatted-impacted-artifacts.txt

while IFS= read -r imageCheck; do
  # extract the image from the file, trim the quotes, and replace the : with a ;
  # Look for the image in the imapacted artifacts and if found print the line to the list. 
  if grep -Fxq "$imageCheck" d-formatted-impacted-artifacts.txt
  then
     echo $imageCheck >> d-impacted-user-images.txt
  fi
done < d-notebook-artifactory-comp.txt
