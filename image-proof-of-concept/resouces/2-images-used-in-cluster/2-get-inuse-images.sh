#!/bin/sh

###############################################
# Purpose: Obtain a list of images being used in the cluster
#####
# Actions: kubectl to obtain a json list of images
# There are two main lists
# 1: The first kubectl gets all notebook images.
### These will be used for patching
# 2: The second kubectl gets all images.
### These are used for letting admins know and to let the program know that 
### certain images should not be deleted (because they are in use)
# Formats into just image paths for simple comparison with Artifactory
#####
# TODO: Change kubectl to use all namespaces instead of jose-matsuda, uncomment kubectl commands
###############################################

#kubectl get notebook --namespace jose-matsuda -o json | jq -c '.items[] | {Namespace:(.metadata.namespace), ImagePath:(.spec.template.spec.containers[0].image), 
# Name:(.spec.template.spec.containers[0].name), Version: (.metadata.labels.version)}' | sort | uniq > 2-kubectl-notebook.txt

# Compile a list of JUST images and paths, trimming quotes. 
cat 2-kubectl-notebook.txt | 
while read -r line
do
  echo $line | jq '.ImagePath' | tr -d '"' >> 2-notebook-images.txt #for now a dummy list
done

# Replace any : with / for easy comparison with artifactory and write to a different file
# If you remove the last 'awk' this may no longer be needed. 
sed "s/:/\//" 2-notebook-images.txt >> 2-notebook-artifactory-comp.txt 


# kubectl get pods --namespace jose-matsuda -o jsonpath="{.items[*].spec.containers[*].image}" | tr -s '[[:space:]]' '\n' | sort | uniq >> 2-kubectl-pod-images.txt
# Replace any : with / for easy comparison with artifactory
# Used in Step 3 for an 'ultimate' do not delete these "old" images but are actively in use. 
sed -i "s/:/\//" 2-kubectl-pod-images.txt

# Remove any images used in notebooks found from the get pods. Might not be needed 
awk 'NR==FNR{a[$0];next} !($0 in a)' 2-notebook-artifactory-comp.txt 2-kubectl-pod-images.txt >> 2-used-non-notebook-images.txt