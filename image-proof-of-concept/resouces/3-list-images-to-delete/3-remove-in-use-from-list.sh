#!/bin/sh

# Keep entries that are ONLY in fileA. 
# Each file must have a newline
# Remove all images in use by the cluster from the delete list. This has to be the 'generic' all pods list
awk 'NR==FNR{a[$0];next} !($0 in a)' 2-kubectl-pod-images.txt 1-old-image-list.txt >> 3-to-delete.txt