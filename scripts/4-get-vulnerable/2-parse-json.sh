#!/bin/sh

#just a helper file to give me readable things
#need to get 'impacted_artifacts'
# impacted artifacts itself is encased in '[]' and could have multiple in it.
# see:https://www.jfrog.com/confluence/display/JFROG/Xray+REST+API#XrayRESTAPI-GetViolations

cat 4-violations.json |  jq -c '.violations[].impacted_artifacts[]' | sort | uniq >> 2-impacted-artifacts.txt

sed -i 's/\"//g' 2-impacted-artifacts.txt
#where is this default from?

#this needs to be compared with 2-notebook-images to produce some list of impacted images in cluster. 