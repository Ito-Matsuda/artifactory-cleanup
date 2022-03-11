# Step XY: The Delete

Not too sure on where to place this one in the process just yet. For now I'll have it be one of the last steps. Should at least be after the update-pods. 

Could get called by 3-images to delete once (as these would be unused and old) and then again after the update. 

DO NOT DELETE IMAGES THAT HAVE DO NOT HAVE A SUITABLE IMAGE TO UPDATE TO.

# Input

3-to-delete.txt: A list of images to delete. These images are the old and unused images. 

_____???.txt: These are a list of notebook images that need to be deleted AFTER they have been updated. (user was fine with the update / ignored it)

# Result

Images in Artifactory specified in 3-to-delete have been removed.

# Old Notes / Ramblings

Now this can be done via artifactory api --> https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-DeleteItem

Or can also be done through the regular docker registry api --> https://docs.docker.com/registry/spec/api/#deleting-an-image 

(requires name and digest) docker images --digest would give you this. 


https://www.jfrog.com/confluence/display/JFROG/Docker+Registry#DockerRegistry-Overview
`Artifactory supports the relevant calls of the Docker Registry API so that you can 
transparently use the Docker client to access images through Artifactory.`


https://betterprogramming.pub/automate-docker-registry-cleanup-3a1af0aa1535
The way to do via docker registry seems to be similar in gathering tags older than 30 days and then untagging them, then just calling some garbage collection. 
