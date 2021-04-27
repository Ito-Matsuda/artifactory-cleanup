#!/bin/sh

# Gets a list of old images per old-images-request
# Then formats the output into a 'repo'+'path' so it can easily be compared to step 2's kubectl image get 
#curl -u myuser:example -X POST "https://testjosez.jfrog.io/artifactory/api/search/aql" -H "content-type: text/plain" -d @sample.aql
#this will change in ours, this url looks to my cloud currently. the -H content-type: text/plain is necessary. 
URL="https://testjosez.jfrog.io/artifactory/api/search/aql"
curl -u myUser:<Token> -X POST $URL -H "content-type: text/plain" -d @old-images-request.txt >> artifactory-get.json 


cat artifactory-get.json | jq -c '.results[] | {completepath: "\(.repo)/\(.path)"}' |
while read -r line
do
  echo $line | jq '.[]' |  tr -d '"' >> 1-image-list.txt
done 