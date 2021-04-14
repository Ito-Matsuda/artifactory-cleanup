#!/bin/sh

curl -u myuser:passwordhere -X POST "https://testjosez.jfrog.io/artifactory/api/search/aql" -H "content-type: text/plain" -d @sample.txt >> image-list.json 