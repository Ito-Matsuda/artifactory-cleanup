#!/bin/sh

# Keep entries that are ONLY in fileA. 
# File C requires an ending newline for read in the next script to work properly
# awk 'NR==FNR{a[$0];next} !($0 in a)' fileB fileA >> fileC
# Remove all images in use by the cluster from the delete list.
awk 'NR==FNR{a[$0];next} !($0 in a)' 2-kubectl-pod-images.txt 1-old-image-list.txt >> 3-to-delete.txt