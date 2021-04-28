#!/bin/sh

URL="https://testjosez.jfrog.io/artifactory/api/search/aql"
#changed for testing to find things older than 1 week
curl -u myuser:password! -X POST $URL -H "content-type: text/plain" -d @1-aql-get-images.txt >> 1-image-list.json 