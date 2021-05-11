#!/bin/sh

URL="https://testjosez.jfrog.io/artifactory/api/search/aql"
#changed for testing to find things older than 1 week
curl -u myuser:red! -X POST $URL -H "content-type: text/plain" -d @1-aql-get-images.txt >> 1-image-list.json 
#items.find({"name":{"$eq":"manifest.json"},"created":{"$before":"1w"}})
#https://stackoverflow.com/questions/32277479/how-to-get-properties-of-an-artifact-in-artifactory 

#Semantic versioning test  is 1-i.json
#items.find({"name":{"$eq":"manifest.json"},"@docker.label.version":{"$gt":"1.5.1"}, "path":{"$match":"my-docker-image/*"}})
#items.find({"name":{"$eq":"manifest.json"},"@docker.manifest":{"$eq":"vulnerablehope"}, "path":{"$match":"*"}})