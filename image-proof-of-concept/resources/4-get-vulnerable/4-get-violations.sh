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

#/default configs (delete if not needed)
#where is this default from? if our version does not have this then we can get rid of 4C and just use 4B
#Unsure if the default/ will exist in ours. Here's code to remove it anyways
awk '{gsub("default/","");print}' <<< cat 4B-impacted-artifacts.txt >> 4C-formatted-impacted-artifacts.txt
#end /default configs

# There's also a trailing slash for whatever reason at the end get rid of it
sed -i 's/.$//' 4C-formatted-impacted-artifacts.txt

#Change all `/` of 4C-formatted-impacted-artifacts to `;`
sed -i 's/\//;/g' 4C-formatted-impacted-artifacts.txt


# Remove any images from 4C that exist in our manifest "good" files. This means that we do not have a suitable upgrade for them
# and as such should not perform any action like patching or deleting from artifactory on them
# if it is not in the 4C list, then notebook comparisons wont happen and 

# For now in testing have the name be different.
curl -o 4Z-spawnerfile.yaml https://raw.githubusercontent.com/StatCan/kubeflow-manifest/master/kustomize/application/jupyter-web-app/configs/spawner_ui_config.yaml

# Format
yq e '.spawnerFormDefaults.image.options[]' 4Z-spawnerfile.yaml >> 4Z-sanctified-images.txt


#Replace the slashes with a semicolon to compare with 4C
# If the 'safe' image is a vulnerable image.
# We do NOT take action. (ie remove it from the 4C-impacted artifacts)
sed 's/\//;/g' 4Z-sanctified-images.txt | 
while read -r line
do
  compare=$(sed 's/:/;/g' <<< $line) #Produce a variable containing something to search for in 4C
  if grep -Fxq $compare 4C-formatted-impacted-artifacts.txt 
    then #If the "good" image is vulnerable, take no action.
      taglessimage="$(retrieve_tagless_path $line)" #extract path
      sed -i "/$taglessimage/d" 4C-formatted-impacted-artifacts.txt #delete from 4C
      echo $compare >> 4-email-admin.txt 
      # We want to let admins know about this image that does not have an update image.
  fi
done

#Returns the leading path ie) keep everything before the image tag
retrieve_tagless_path () {
  imagepath=${1%:*}
  echo $imagepath
}

# This is for stuff in 4C (copy paste etc).
#k8scc01covidacr.azurecr.io;jupyterlab-cpu;blah
#k8scc01covidacr.azurecr.io;jupyterlab-cpu;f25cad42