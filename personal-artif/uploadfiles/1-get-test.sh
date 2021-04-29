#!/bin/sh

URL="https://testjosez.jfrog.io/artifactory/api/search/aql"
#changed for testing to find things older than 1 week
#curl -u myuser:! -X POST $URL -H "content-type: text/plain" -d @1-aql-get-test.txt

URL="https://testjosez.jfrog.io/artifactory/docker-quickstart-local/test.txt"
curl -u myuser:! -XGET $URL --output downloaded.txt