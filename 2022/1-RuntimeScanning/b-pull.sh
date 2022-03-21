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
### crane pull jfrog.aaw.cloud.statcan.ca/k8s...io/jupyterlab-cpu:f25cad42
### In the event that the output does not match what we expect break after 10 sleeps
###############################################

crane auth login -u $JFROG_USERNAME -p $JFROG_PASSWORD jfrog.aaw.cloud.statcan.ca
while IFS= read -r line; do
  crane pull jfrog.aaw.cloud.statcan.ca/$line temporary 
  rm temporary
done < a-uniqe-nb-images.txt


## TEST, this doesnt work super well
# crane auth login jfrog.aaw.cloud.statcan.ca -u aaa -p aaaa
#until crane pull jfrog.aaw.cloud.statcan.ca/jose-play/busybox:stable-glibc temporary 2>&1 \
#  | grep -m 1 "(compressed) in cache\|Forbidden"
#  do
#    sleep 1
#    ((count++))
#    if [ $count -eq 10 ]
#      then
#      break
#    fi
#  done
