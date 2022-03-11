#!/bin/bash

###############################################
# Purpose: Pull images from artifactory
#####
# Actions: Attempt to pull images from the list of images on a notebook
# Requires:
## A txt file containing a list of notebook images in cluster (uniq'd)
## Configuration to pull from Artifactory (could make anonymous ok?). 
# Extra Info
#### each line in text file should represent an image looking like k8s...io/jupyterlab-cpu:f25cad42
### Send pull requests to Artifactory
### docker pull jfrog.aaw.cloud.statcan.ca/k8s...io/jupyterlab-cpu:f25cad42
# https://askubuntu.com/a/424333
###############################################


cat 2-uniqe-nb-images.txt | 
while read -r line
do
  #docker pull jfrog.aaw.cloud.statcan.ca/$line 2>&1 | 
  if grep -Fxq "Error response from daemon: unknown: Forbidden"
  then
    echo $line >> impacted-images.txt
  fi
  # impacted-images is a list of vulnerable images.
  # redirect the output and check for "Error response from daemon?"
done