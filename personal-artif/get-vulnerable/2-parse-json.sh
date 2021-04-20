#!/bin/sh

#just a helper file to give me readable things
#need to get 'impacted_artifacts'
# impacted artifacts itself is encased in '[]' and could have multiple in it.
# see:https://www.jfrog.com/confluence/display/JFROG/Xray+REST+API#XrayRESTAPI-GetViolations

cat example-violations.json |  jq -c '.violations[].impacted_artifacts[]' >> 2-impacted_artifacts.txt

#where is this default from?