#The actual delete
#This should only delete images that are old, or are vulnerable. Does NOT delete any in use images (unless vulnerable would be added by step 4)

#pseudo code
#recall the output of the search

#    "results": [
#        {
#            "repo": "docker-remote-repo-cache",
#            "path": "alpine/latest",
#            "name": "manifest.json",

# Sample Usage DELETE http://localhost:8081/artifactory/libs-release-local/ch/qos/logback/logback-classic/0.9.9

#So we need the url+repo+path

#Kind of weird!?!? Need to do string construction to build the url.
#I dont think I can avoid this. Looking at the docker registry api (which is used via artifactory) need something like
# DELETE /v2/<name>/manifests/<reference> --> For deletes, reference must be a digest or the delete will fail.