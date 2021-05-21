#!/bin/sh

###############################################
# Purpose: Obtain a list of images that are unused in the cluster
#####
# Input: 
# 2-kubectl-pod-images.txt: A complete list of all images in the cluster
# 1-old-image-list.txt: A list of all images in Artifactory that are older than X period
# Note: It is important that each of these files have a 'newline'
#####
# Actions: Take only images that are only in 1-old-image-list
###############################################

awk 'NR==FNR{a[$0];next} !($0 in a)' 2-kubectl-pod-images.txt 1-old-image-list.txt >> 3-to-delete.txt