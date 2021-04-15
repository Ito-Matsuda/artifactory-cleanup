#!/bin/sh

# cat 1-image-list.json | jq -c '.results[0] .path'
# cat 1-image-list.json | jq -c '.results[] | {repo: .repo, path: .path}' > 2-extract-rep-path.json
# OR

# Outputs JSON neatly line by line. 
cat 1-image-list.json | jq -c '.results[] | {completepath: "\(.repo)/\(.path)"}' |
while read -r line
do
  echo $line | jq '.[]' >> 2-artif.txt
done

#Remove quotes from 2-artif (for easy comparison with kubectl)
sed -i 's/\"//g' 2-artif.txt

#Example of output from kubectl --> k[redacted?]r.azurecr.io/jupyterlab-cpu:dee04931 
# kubectl get pods --all-namespaces -o jsonpath="{.items[*].spec.containers[*].image} tr -s '[[:space:]]' '\n'> 2-sample-kubectl.txt"
# Replace the ":" with a /
sed -i "s/:/\//" 2-sample-kubectl.txt