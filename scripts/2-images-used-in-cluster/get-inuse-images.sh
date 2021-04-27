#!/bin/sh

#Example (on personal work linux where i have kubectl set up)
#Should eventually be (with permissions)
#kubectl get pods --all-namespaces -o jsonpath="{.items[*].spec.containers[*].image} tr -s '[[:space:]]' '\n'> keep-images.json"
# (the tr-s ... makes each image appear on their own line), then sort, and then just retain unique images.
#kubectl get pods --namespace jose-matsuda -o jsonpath="{.items[*].spec.containers[*].image}" | tr -s '[[:space:]]' '\n' | sort | uniq > keep-images.txt

#change to all namespaces 
#kubectl get notebook --namespace jose-matsuda -o json | jq -c '.items[] | {Namespace:(.metadata.namespace), ImagePath:(.spec.template.spec.containers[0].image), Name:(.spec.template.spec.containers[0].name)}' | sort | uniq > 2-completelist.txt
#this gets a list of everything , will likely all be unique as well. There MUST be a new line (empty) at the end. 
#now parse it into other information necessary. For this step we can parse it into JUST the imagepath for now. 

# Compile a list of JUST images and paths, trimming quotes. 
cat completelist.txt | 
while read -r line
do
  echo $line | jq '.ImagePath' | tr -d '"' >> 2-image-in-use.txt #for now a dummy list
done

# Replace any : with / for easy comparison with ACR
sed -i "s/:/\//" 2-image-in-use.txt