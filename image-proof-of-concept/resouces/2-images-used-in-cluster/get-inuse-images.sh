#!/bin/sh

#Get the NOTEBOOK images

#would uncomment below, change to use all namespaces
#kubectl get notebook --namespace jose-matsuda -o json | jq -c '.items[] | {Namespace:(.metadata.namespace), ImagePath:(.spec.template.spec.containers[0].image), 
# Name:(.spec.template.spec.containers[0].name), Version: (.metadata.labels.version)}' | sort | uniq > 2-kubectl-notebook.txt

# Compile a list of JUST images and paths, trimming quotes. 
cat 2-kubectl-notebook.txt | 
while read -r line
do
  echo $line | jq '.ImagePath' | tr -d '"' >> 2-notebook-images.txt #for now a dummy list
done

# Replace any : with / for easy comparison with artifactory and write to a different file
# Different because 2-notebook-images is useful later when making vulnerability comparisons
# If you remove the last 'awk' this may no longer be needed. 
sed "s/:/\//" 2-notebook-images.txt >> 2-notebook-artifactory-comp.txt 

# Compile a list of ALL (even notebooks) images and paths. These will NOT be automatically updated but will need to let an admin know about them
# would uncomment below
# kubectl get pods --namespace jose-matsuda -o jsonpath="{.items[*].spec.containers[*].image}" | tr -s '[[:space:]]' '\n' | sort | uniq >> 2-kubectl-pod-images.txt

# Replace any : with / for easy comparison with artifactory
# Keep this uncommented as it is used in Step 3 for an 'ultimate' do not delete these images. 
sed -i "s/:/\//" 2-kubectl-pod-images.txt

# Remove any images used in notebooks found from the get pods.
# This might be useless now. 
awk 'NR==FNR{a[$0];next} !($0 in a)' 2-notebook-artifactory-comp.txt 2-kubectl-pod-images.txt >> 2-used-non-notebook-images.txt