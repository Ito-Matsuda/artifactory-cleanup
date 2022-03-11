#!/bin/sh

#just me testing out things
URL="https://testjosez.jfrog.io/artifactory/api/search/aql"
curl -u myuser:... -X POST $URL -H "content-type: text/plain" -d @sample.txt >> test.json 