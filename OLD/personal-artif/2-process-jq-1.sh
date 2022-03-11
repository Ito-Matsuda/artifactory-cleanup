#!/bin/sh

# cat 1-image-list.json | jq -c '.results[0] .path'
# cat 1-image-list.json | jq -c '.results[] | {repo: .repo, path: .path}' > 2-extract-rep-path.json
# OR

# Outputs JSON neatly line by line. 
# 'cat ...' does also have a newline (good) at the end
cat 1-image-list.json | jq -c '.results[] | {completepath: "\(.repo)/\(.path)"}' |
while read -r line
do
  echo $line | jq '.[]' >> 2-artif.txt
done

#Remove quotes from 2-artif (for easy comparison with kubectl)
sed -i 's/\"//g' 2-artif.txt

#Example of output from kubectl 
# kubectl get pods --namespace jose-matsuda -o json | jq -c '.items[] | {Namespace:(.metadata.namespace), RepoPath:(.spec.containers[0].image), ContName:(.spec.containers[0].name), PodName:(.metadata.name)}' | sort | uniq
#kubectl get pods --namespace jose-matsuda -o json | jq -c '.items[] | {data:"\(.metadata.namespace)+\(.spec.containers[].image)"}' | sort | uniq > keep-images.txt
#should the '.spec.containers[].image' instead be '.spec.containers[0].image'??? this avoids the istio and vault images
#   may want spec containers name as well (to be able to update pods)
# that also appear in the pod spec which we don't want to replace? 
#how is our pod(?) spec created? Is it like the image they choose first will always be the first image? 
#produces something like so now we have the namespace as well. 
# {"data":"jose-matsuda+k8s....azurecr.io/jupyterlab-cpu:deeeeeeee"}
# might also need spec.containers[].name
#this step may now change... branch into two different forms? 

#kubectl get notebooks --namespace jose-matsuda --> A LOT CLEANER
#kubectl get notebook --namespace jose-matsuda -o json | jq -c '.items[] | {Namespace:(.metadata.namespace), ImagePath:(.spec.template.spec.containers[0].image), ContName:(.spec.template.spec.containers[0].name)}' | sort | uniq > 2-completelist.txt


# Replace the ":" with a /
sed -i "s/:/\//" 2-sample-kubectl.txt