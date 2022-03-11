#!/bin/sh

#this URL will change for our artifactory instance (not the same base as the cloud one.)
URL="https://testjosez.jfrog.io/xray/api/v1/violations"

#ping it
#curl -u myuser:! -X GET https://testjosez.jfrog.io/xray/api/v1/system/ping

curl -u myuser:! -X POST $URL -H "Content-Type: application/json" -d @violationscheck.json > 1-violations.json
