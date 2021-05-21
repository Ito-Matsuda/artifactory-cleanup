#!/bin/sh

###############################################
# Purpose: Obtain a list of images from artifactory that meet the requirements
## The requirements will be an 'age' requirement for 'old' images
#####
# Input: Relies on a .txt file containing Artifactory Query Language
#####
# Actions: API call to Artifactory with a .txt file to get a JSON
# Retrieves just the image paths for simple comparison with kubectl
#####
# TODO: Change the URL, obtain relevant credentials, confirm the .txt request
###############################################

# Get a list of images whose creation date is older than 4 weeks and their last download date is older than a week
URL="https://testjosez.jfrog.io/artifactory/api/search/aql"
curl -u myUser:<Token> -X POST $URL -H "content-type: text/plain" -d @old-images-request.txt >> 1-artifactory-get.json 

cat artifactory-get.json | jq -c '.results[] | {completepath: "\(.repo)/\(.path)"}' |
while read -r line
do
  echo $line | jq '.[]' |  tr -d '"' >> 1-old-image-list.txt
done 