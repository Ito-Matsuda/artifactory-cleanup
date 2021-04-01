# I don't have much idea here aside from the kubectl run.
# Where will this run???

#Example (on personal work linux where i have kubectl set up)
kubectl get pods --namespace jose-matsuda -o jsonpath="{.items[*].spec.containers[*].image}"
#produces something like


#Should eventually be (with permissions)
#kubectl get pods --all-namespaces -o jsonpath="{.items[*].spec.containers[*].image}"
