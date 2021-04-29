Step X: Forcibly update notebooks that were not actioned on. 



# CONCERNS
What if image name changes?
How will I do a best fit kind of image change / just the most recent one?
If there's no suitable image DO NOT DELETE the image, send an email perhaps.
You do NOT want to auto-update the other images. 

# For updating 
ACTUALLY NEED TO UPDATE THE NOTEBOOK IMAGE

command that works

kubectl patch Notebook notebookName --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value":"NEWIMAGE"}]'

So I need
Image to update to (this will be more complicated)
notebook name (.metadata.namespace)



`kubectl set image pod/kubernetes-bootcamp-fb5c67579-5l2b5 kubernetes-bootcamp=jocatalin/kubernetes-bootcamp:v2 --namespace default`

https://kubernetes.io/docs/tutorials/kubernetes-basics/update/update-interactive/

https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#updating-a-deployment
If a change is made to .spec.template then a rollout is done

So to do the above I need the following; `kubectl set image pod/podName containerName=updatedImage --namespace userNamespace`

podName: (likely what the user named their notebook server + 0 ex: test-french-0), --> .metadata.name

containerName: (whatever the user named their notebook server ex: test-franch) --> .spec.containers[0].image -->maybe 0 so we dont get vault / istio

updatedImage: the image to update to (may require some messing around if the name doesnt match) --> unsure

userNamespace: which namespace to use, since pod/containernames can be shared in different pods (Saffa and I both had a test-french) -->.metadata.namespace



# Not sure if "patching" is what we want
 https://kubernetes.io/docs/reference/kubectl/cheatsheet/#patching-resources

 and

 https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#patch

# OLD THOUGHTS BELOW


ROLLING RESTART?

https://github.com/kubernetes/kubernetes/issues/13488#issuecomment-691916143
https://stackoverflow.com/questions/40366192/kubernetes-how-to-make-deployment-to-update-image

https://stackoverflow.com/questions/57559357/how-to-rolling-restart-pods-without-changing-deployment-yaml-in-kubernetes

How do i get the name of a deployment? 



STEP X

Some update of pods? Might need to be ran on demand? Using 4-get-vulnerable and then some other step matching it to a list of
currently in use images.