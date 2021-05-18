#!/bin/sh

#this URL will change for our artifactory instance (not the same base as the cloud one.)
URL="https://testjosez.jfrog.io/xray/api/v1/violations"

# Currently checks for only CRITICAL vulnerabilities
# Can change the filter to use a certain 'watch' --> "watch_name": "watch",
curl -u myuser:! -X POST $URL -H "Content-Type: application/json" -d @4-violationscheck.json >> 4-violations.json
