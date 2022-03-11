#!/bin/sh

# Gets a list of younger images
URL="https://testjosez.jfrog.io/artifactory/api/search/aql"

# Maybe this 'request' should change. 
# In that instead you change what's in the --> "archive.entry.path":{"$eq":"org/artifactory"}
# Because the path would stay the same to the tag (this falls through if the path / image name underwent a change).
# under which perhaps an ADMIN should be notified. 
# EX: 
#     default/docker-quickstart-local/my-docker-image/5eefshacode/
#     default/docker-quickstart-local/my-docker-image/delete1/
# Then compare by 'created date'?
# So for each vulnerable image in the cluster, use the path from it 
curl -u myUser:<Token> -X POST $URL -H "content-type: text/plain" -d @old-images-request.txt >> artifactory-get.json 

cat artifactory-get.json | jq -c '.results[] | {completepath: "\(.repo)/\(.path)"}' |
while read -r line
do
  echo $line | jq '.[]' |  tr -d '"' >> h-new-image-list.txt
done 

# Should include something to catch if a suitable replacement image is not found then mention in an email yada yada. 