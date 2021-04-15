#!/bin/sh

#curl -u myuser:example -X POST "https://testjosez.jfrog.io/artifactory/api/search/aql" -H "content-type: text/plain" -d @sample.aql
#this will change in ours, this url looks to my cloud currently. the -H content-type: text/plain is necessary. 
curl -u myUser:<Token> -X POST "https://testjosez.jfrog.io/artifactory/api/search/aql" -H "content-type: text/plain" -d @old-images-request.txt >> image-list.json 


#Example
#  "results" : [ {
#      "repo" : "docker-quickstart-local",
#      "path" : "hello-world/latest",
#      "name" : "manifest.json",
#      ...
#    },{
#      "repo" : "docker-quickstart-local",
#      "path" : "my-docker-image/1reusedlayer",
#      "name" : "manifest.json",

# To process that into just repo and path can use: cat test.json | jq -c '.results[] | {repo: .repo, path: .path}' > extract-rep-path.json