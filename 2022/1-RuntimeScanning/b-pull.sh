#!/bin/bash

###############################################
# Purpose: Pull images from artifactory
#####
# Actions: Pull images, but also quit out once it tries to pull (ie pass artif scanning)
# Requires:
## A txt file with a newline containing a list of notebook images in cluster (uniq'd)
### a-uniqe-nb-images.txt
## Configuration to pull from Artifactory (could make anonymous ok?). 
# Extra Info
### each line in text file should represent an image looking like k8s...io/jupyterlab-cpu:f25cad42
### The artifactory remote repository should share the same name as the ACR
### docker pull jfrog.aaw.cloud.statcan.ca/k8s...io/jupyterlab-cpu:f25cad42
### In the event that the output does not match what we expect break after 10 sleeps
###############################################

# https://docs.docker.com/engine/security/rootless/

count=0
while IFS= read -r line; do
  until docker pull jfrog.aaw.cloud.statcan.ca/$line 2>&1 | grep -m 1 "Pulling from\|Error response from daemon:"
  do
    sleep 1
    ((count++))
    if [ $count -eq 10 ]
      then
      break
    fi
  done
  count=0
done < a-uniqe-nb-images.txt