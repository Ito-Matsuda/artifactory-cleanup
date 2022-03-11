#!/bin/bash

###############################################
# Purpose: Obtain a list of notebook images being used in the cluster
#####
# Actions: kubectl to obtain a json list of images
# There are two main lists
# 1: The first kubectl gets all notebook images.
### These will be used for patching
###############################################

kubectl get notebook --all-namespaces -o json | jq -c '.items[] | {Namespace:(.metadata.namespace), ImagePath:(.spec.template.spec.containers[0].image), 
 Name:(.spec.template.spec.containers[0].name), Version: (.metadata.labels.version)}' | sort | uniq > 2-kubectl-notebook.txt

# Compile a list of JUST images and paths, trimming quotes. 
cat 2-kubectl-notebook.txt | 
while read -r line
do
  echo $line | jq '.ImagePath' | tr -d '"' > 2-notebook-images.txt
done
# Formats like k8s...io/jupyterlab-cpu:taghere. This is useful for PULLING the image

# Sort and put into a text file so only try pulling each image once
sort 2-notebook-images.txt | uniq > 2-uniqe-nb-images.txt






# Replace any : with / for easy comparison with artifactory and write to a different file, might be useful for
# comparing with vulnerabilities from the report.
#sed "s/:/\//" 2-notebook-images.txt >> 2-notebook-artifactory-comp.txt 
