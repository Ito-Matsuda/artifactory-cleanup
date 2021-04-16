#!/bin/sh

# Gets a list of old images per old-images-request
# Then formats the output into a 'repo'+'path' so it can easily be compared to step 2's kubectl image get 
#curl -u myuser:example -X POST "https://testjosez.jfrog.io/artifactory/api/search/aql" -H "content-type: text/plain" -d @sample.aql
#this will change in ours, this url looks to my cloud currently. the -H content-type: text/plain is necessary. 
URL="https://testjosez.jfrog.io/artifactory/api/search/aql"
curl -u myUser:<Token> -X POST $URL -H "content-type: text/plain" -d @old-images-request.txt >> image-list.json 

# To process that into just repo and path can use: cat test.json | jq -c '.results[] | {repo: .repo, path: .path}' > extract-rep-path.json
# or for just an object completePath that combines both repo and path (no url)
cat image-list.json | jq -c '.results[] | {completepath: "\(.repo)/\(.path)"}' > 2-combined.json

while read -r line
do
  echo $line | jq '.[]' >> format-image-list.txt
done < 2-combined.json