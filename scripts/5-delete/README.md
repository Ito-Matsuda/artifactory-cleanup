# Step 5: The Delete

Now this can be done via artifactory api --> https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-DeleteItem

Or can also be done through the regular docker registry api --> https://docs.docker.com/registry/spec/api/#deleting-an-image 

(requires name and digest) docker images --digest would give you this. 


https://www.jfrog.com/confluence/display/JFROG/Docker+Registry#DockerRegistry-Overview
`Artifactory supports the relevant calls of the Docker Registry API so that you can 
transparently use the Docker client to access images through Artifactory.`


https://betterprogramming.pub/automate-docker-registry-cleanup-3a1af0aa1535
The way to do via docker registry seems to be similar in gathering tags older than 30 days and then untagging them, then just calling some garbage collection. 
