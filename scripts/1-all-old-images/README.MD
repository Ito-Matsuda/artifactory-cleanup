STEP 1: Obtain list of images older than X Period of time

# Output

1-image-list -> Final Output (1/1): A list from artifactory containing images older than the period specified in `old-images-request.txt` 

## IMPORTANT

Currently it looks for images that have not been downloaded in the last 4 weeks. If we want created date go with 

`items.find({"name":{"$eq":"manifest.json"},"created":{"$before":"1w"}})`

https://www.jfrog.com/confluence/display/RTF3X/Artifactory+Query+Language



# Old Notes / Ramblings

Get list of all manifests older than X period of time. 
Note that it has to be *manifests* (do not search by name) to entirely delete it. 

The script would hopefully produce something like in example-image-list.json
From here we want [repo], [path] and [name] 

`Repo` will be where the image is

`path` would hopefully be the location in the repo the 'name' of the image, hopefully something like "jupyterlab-cpu/dee04931" that matches our current image tag.
https://stackoverflow.com/questions/42549119/artifactory-count-of-images-in-docker-registry

`name` would just be 'manifest' as that's what we search on + what holds the info on the layers. 


So a question would be to actually check in artifactory to see where the manifests are stored (path) to see if we can use that to easily match up to
images currently in use using kubectl.