#!/bin/bash

###############################################
# Purpose: Obtain a list of images that have passed a vulnerability threshold
#####
# Input: Relies on a JSON file containing what severity to look for
# Note that a Policy and Watch must be configured in Artifactory.
#####
# Actions: API call to Artifactory. 
# Format to get the impacted artifacts in a list
#####
# TODO: Change the URL, obtain relevant credentials, confirm the .json request
###############################################

URL="https://testjosez.jfrog.io/xray/api/v1/violations"

# Currently checks for only CRITICAL vulnerabilities
# Can change the filter to use a certain 'watch' --> "watch_name": "watch",
curl -u myuser:$1 -X POST $URL -H "Content-Type: application/json" -d @4-violationscheck.json >> 4-violations.json

# impacted artifacts itself is encased in '[]' and could have multiple in it.
# see:https://www.jfrog.com/confluence/display/JFROG/Xray+REST+API#XrayRESTAPI-GetViolations
cat 4-violations.json |  jq -c '.violations[].impacted_artifacts[]' | sort | uniq >> 4B-impacted-artifacts.txt

sed -i 's/\"//g' 4B-impacted-artifacts.txt
#where is this default from? if our version does not have this then we can get rid of 4C and just use 4B

#Unsure if the default/ will exist in ours. Here's code to remove it anyways
awk '{gsub("default/","");print}' <<< cat 4B-impacted-artifacts.txt >> 4C-formatted-impacted-artifacts.txt
# There's also a trailing slash for whatever reason at the end get rid of it
sed -i 's/.$//' 4C-formatted-impacted-artifacts.txt
