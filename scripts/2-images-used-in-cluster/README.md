STEP 2: Grab images in use

# Output

2-kubectl-pod-images.txt -> Intermediate step: contains output of `kubectl get pods`

2-kubectl-notebook.txt -> Final Output (1/3): contains the output of `kubectl get notebook` in JSON form. This contains the full image path, the notebook name, as well as the namespace of the notebook.

2-notebook-images.txt -> Final Output (2/3): Using `2-kubectl-notebook.txt` extracts just the full image path to be used to compare with artifactory.

2-used-non-notebook-images.txt -> Final Output (3/3): Using `2-kubectl-pod-images.txt` and `2-notebook-images.txt` gets a list of all images that exist in the cluster, but are not attached to a notebook. Any vulnerabilities found in these images by artifactory (comparing lists) will have a notification sent to an admin containing the image path (which has the name and tag in it).  
## (MIGHT NO LONGER BE NEEDED SINCE I NEED MORE INFORMATION. Instead run another kubectl when needed.)

# Old Notes / Ramblings
Using kubectl get a full list of images currently in use. Images here should NOT BE REMOVED from Artifactory.
We will not remove any images in use unless there is something like a vulnerability found. 

Even then we would need to migrate that user's image to an upgraded image (need to find this out)


Hopefully, we can use this in combination with the getting of the `manifest.json`'s older than X period. 
