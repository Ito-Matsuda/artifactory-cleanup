#!/bin/sh

# cat image-list.json | jq -c '.results[0] .path'
# cat image-list.json | jq -c '.results[] | {repo: .repo, path: .path}' > extract-rep-path.json
# Outputs JSON neatly line by line. 

#Read line by line 
#while read -r line
#do
#  echo $line
  #echo "new line/ do stuff"
#done < extract-rep-path.json 

#Example of output from kubectl --> k[redacted?]r.azurecr.io/jupyterlab-cpu:dee04931 
# Replace the ":" with a /