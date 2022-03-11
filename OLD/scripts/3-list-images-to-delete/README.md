STEP 3: Make a list of images to delete

# Input 

1-old-image-list -> From step 1, images older than X period of time

2-kubectl-pod-images -> From step 2, ALL images (including notebook) in use in the cluster

# Output

3-to-delete -> A list of images that are X period of time old that are NOT being used in the cluster.

This list would be a list of images that we can safely delete since they are unused and old. That's it for this step.


# Old Notes / Ramblings

Create a json of `images-to-delete` whose contents are from `image-list.json` minus `keep-images.json`.
Where again hopefully the `path` from `image-list.json` will match up nicecly with the names provided by `keep-images.json`(kubectl)

JSON contains repo, path (hoping something like: jupyterlab/dee04931), and name (manifest.json)

Process: 
1) Change the output from Step 2 from something like repo/whatever/jupyterlab-cpu:someTag to repo/whatever/jupyterlab-cpu/someTag
2) Using output from Step 1 combine the repo + path. 
3) Remove any items found in both steps above (meaning said image is in use)