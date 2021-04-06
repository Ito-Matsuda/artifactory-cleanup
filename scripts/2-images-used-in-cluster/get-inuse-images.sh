# I don't have much idea here aside from the kubectl run.
# Where will this run???

#Example (on personal work linux where i have kubectl set up)
kubectl get pods --namespace jose-matsuda -o jsonpath="{.items[*].spec.containers[*].image}" >> keep-images.json
#produces something like (i formatted to keep nice, is normally on one line)
#k[redacted?]r.azurecr.io/jupyterlab-cpu:dee04931 
#docker.io/istio/proxyv2:1.5.10 
#vault:1.5.5 
#gcr.io/ml-pipeline/frontend:1.0.4 
#docker.io/istio/proxyv2:1.5.10 
#gcr.io/ml-pipeline/visualization-server:1.0.4 
#docker.io/istio/proxyv2:1.5.10 
#k[redacted?]r.azurecr.io/jupyterlab-cpu:dee04931 
#docker.io/istio/proxyv2:1.5.10 vault:1.5.5

#Should eventually be (with permissions)
#kubectl get pods --all-namespaces -o jsonpath="{.items[*].spec.containers[*].image}"

#If i could get these images to match up with their respective manifest id in artifactory that would be ACE
