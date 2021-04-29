#!/bin/sh

#Example (on personal work linux where i have kubectl set up)
#Should eventually be (with permissions)
#kubectl get pods --all-namespaces -o jsonpath="{.items[*].spec.containers[*].image} tr -s '[[:space:]]' '\n'> keep-images.json"
# (the tr-s ... makes each image appear on their own line), then sort, and then just retain unique images.
#kubectl get pods --namespace jose-matsuda -o jsonpath="{.items[*].spec.containers[*].image}" | tr -s '[[:space:]]' '\n' | sort | uniq > keep-images.txt

#Get the NOTEBOOK images

#would uncomment below
#kubectl get notebook --namespace jose-matsuda -o json | jq -c '.items[] | {Namespace:(.metadata.namespace), ImagePath:(.spec.template.spec.containers[0].image), Name:(.spec.template.spec.containers[0].name)}' | sort | uniq > 2-kubectl-notebook.txt

# Compile a list of JUST images and paths, trimming quotes. 
cat 2-kubectl-notebook.txt | 
while read -r line
do
  echo $line | jq '.ImagePath' | tr -d '"' >> 2-notebook-images.txt #for now a dummy list
done

# Replace any : with / for easy comparison with artifactory
sed -i "s/:/\//" 2-notebook-images.txt

# Now get ALL IMAGES

# Compile a list of ALL images and paths. These will NOT be automatically updated but will need to let an admin know about them
# Perhaps can do a comparison with the list above (notebook images) and uniq'd so that the admin is not notified on user notebook images
# would uncomment below
# kubectl get pods --namespace jose-matsuda -o jsonpath="{.items[*].spec.containers[*].image}" | tr -s '[[:space:]]' '\n' | sort | uniq >> 2-kubectl-pod-images.txt

# Replace any : with / for easy comparison with artifactory
sed -i "s/:/\//" 2-kubectl-pod-images.txt

# Remove any images used in notebooks found from the get pods
# Can remove this line if we want to still let admin know that "x" image is bad
awk 'NR==FNR{a[$0];next} !($0 in a)' 2-notebook-images.txt 2-kubectl-pod-images.txt >> 2-used-non-notebook-images.txt