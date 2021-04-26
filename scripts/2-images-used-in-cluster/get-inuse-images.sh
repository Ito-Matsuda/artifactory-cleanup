#!/bin/sh

#Example (on personal work linux where i have kubectl set up)
#Should eventually be (with permissions)
#kubectl get pods --all-namespaces -o jsonpath="{.items[*].spec.containers[*].image} tr -s '[[:space:]]' '\n'> keep-images.json"
# (the tr-s ... makes each image appear on their own line), then sort, and then just retain unique images.
kubectl get pods --namespace jose-matsuda -o jsonpath="{.items[*].spec.containers[*].image}" | tr -s '[[:space:]]' '\n' | sort | uniq > keep-images.txt

# Replace any : with / to make it easy to compare with the repo+path structure of artifactory get api 
sed -i "s/:/\//" keep-images.txt


#The forwardslashes indicates the "repo", the bit after the final (or is it still the first?)f'slash indicates the path
#The bit after the colon `:` indicates the 'tag' of the image, and that is used to sort into folders in artifactory
#There are the istio / vault ones that I am unsure about. I would imagine I don't mess with these anyways so as long as
# they do NOT get caught by deletion it should be fine.


#Might instead want to do 
kubectl get pods --namespace jose-matsuda -o json | jq -c '.items[] | {data:"\(.metadata.namespace)+\(.spec.containers[].image"}' | sort | uniq > keep-images.txt
#produces something like so now we have the namespace as well. 
# {"data":"jose-matsuda+k8s....azurecr.io/jupyterlab-cpu:deeeeeeee"}