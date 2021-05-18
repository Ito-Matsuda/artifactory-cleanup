#!/bin/sh

# Get a list of images whose creation date is older than 4 weeks and their last download date is older than a week
URL="https://testjosez.jfrog.io/artifactory/api/search/aql"
curl -u myUser:<Token> -X POST $URL -H "content-type: text/plain" -d @old-images-request.txt >> 1-artifactory-get.json 


cat artifactory-get.json | jq -c '.results[] | {completepath: "\(.repo)/\(.path)"}' |
while read -r line
do
  echo $line | jq '.[]' |  tr -d '"' >> 1-old-image-list.txt
done 