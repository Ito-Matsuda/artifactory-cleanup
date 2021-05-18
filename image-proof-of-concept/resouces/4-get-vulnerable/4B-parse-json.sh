#!/bin/sh

# Make the json readable
# impacted artifacts itself is encased in '[]' and could have multiple in it.
# see:https://www.jfrog.com/confluence/display/JFROG/Xray+REST+API#XrayRESTAPI-GetViolations

cat 4-violations.json |  jq -c '.violations[].impacted_artifacts[]' | sort | uniq >> 4B-impacted-artifacts.txt

sed -i 's/\"//g' 4B-impacted-artifacts.txt
#where is this default from?

#Unsure if the default/ will exist in ours. Here's code to remove it anyways
awk '{gsub("default/","");print}' <<< cat 4B-impacted-artifacts.txt >> 4C-formatted-impacted-artifacts
# There's also a trailing slash for whatever reason at the end get rid of it
sed -i 's/.$//' 4C-formatted-impacted-artifacts