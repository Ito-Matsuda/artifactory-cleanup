#!/bin/sh

URL="https://testjosez.jfrog.io/artifactory/api/search/aql"
curl -u myuser:passwordhere -X POST $URL -H "content-type: text/plain" -d @1-aql-get-images.txt >> image-list.json 