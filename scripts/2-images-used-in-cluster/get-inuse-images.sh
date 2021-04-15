#!/bin/sh

#Example (on personal work linux where i have kubectl set up)
# (the tr-s ... makes each image appear on their own line) 
kubectl get pods --namespace jose-matsuda -o jsonpath="{.items[*].spec.containers[*].image}" | tr -s '[[:space:]]' '\n'> keep-images.json
#produces something like 
# repo / path1:path2 --> path1 is a folder containing path2 which itself is a folder holding the manifest + layers.  

#docker.io/istio/proxyv2:1.5.10 
#repo/path
#vault:1.5.5 
#/path???
#gcr.io/ml-pipeline/frontend:1.0.4 
#docker.io/istio/proxyv2:1.5.10 
#gcr.io/ml-pipeline/visualization-server:1.0.4 
#docker.io/istio/proxyv2:1.5.10 
#k[redacted?]r.azurecr.io/jupyterlab-cpu:dee04931 
#docker.io/istio/proxyv2:1.5.10 
#vault:1.5.5



#Should eventually be (with permissions)
#kubectl get pods --all-namespaces -o jsonpath="{.items[*].spec.containers[*].image} tr -s '[[:space:]]' '\n'> keep-images.json"

#The forwardslashes indicates the "repo", the bit after the final (or is it still the first?)f'slash indicates the path
#The bit after the colon `:` indicates the 'tag' of the image, and that is used to sort into folders in artifactory
#There are the istio / vault ones that I am unsure about. I would imagine I don't mess with these anyways so as long as
# they do NOT get caught by deletion it should be fine 
