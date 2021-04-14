#!/bin/sh

#curl -u myuser:example -X POST "https://testjosez.jfrog.io/artifactory/api/search/aql" -H "content-type: text/plain" -d @sample.aql
curl -u myUser:<Token> -X POST "https://testjosez.jfrog.io/artifactory/api/search/aql" -H "content-type: text/plain" -d @old-images-request.txt >> image-list.json 