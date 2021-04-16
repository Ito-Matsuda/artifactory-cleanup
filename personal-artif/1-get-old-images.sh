#!/bin/sh

URL="https://testjosez.jfrog.io/artifactory/api/search/aql"
curl -u myuser:password! -X POST $URL -H "content-type: text/plain" -d @1-aql-get-images.txt >> 1-image-list.json 