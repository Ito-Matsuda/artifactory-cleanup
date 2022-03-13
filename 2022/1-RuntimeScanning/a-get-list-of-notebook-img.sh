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
 Name:(.spec.template.spec.containers[0].name), Version: (.metadata.labels.version)}' | sort | uniq > a-kubectl-notebook.txt

# Sample output
# {"Namespace":"jose-matsuda","ImagePath":"k8sc.io/jupyterlab-cpu:16b01881","Name":"jup2","Version":null}

# Compile a list of JUST images and paths, trimming quotes, formats like k8s...io/jupyterlab-cpu:taghere.
cat a-kubectl-notebook.txt | 
while read -r line
do
  echo $line | jq '.ImagePath' | tr -d '"' > a-notebook-images.txt
done
# Sort and put into a text file so only try pulling each image once, used in step b
sort a-notebook-images.txt | uniq > a-uniqe-nb-images.txt