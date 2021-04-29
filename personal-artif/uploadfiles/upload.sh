#!/bin/sh

#this is just a file to upload some random garbo to artifactory (try to upload to a nonexistent directory)
URL="https://testjosez.jfrog.io/artifactory/example-repo-local/"
# URL="https://testjosez.jfrog.io/artifactory/docker-quickstart-local/" <-- works REQUIRES the trailing / 
curl -u myuser:! -XPUT $URL -T test.txt