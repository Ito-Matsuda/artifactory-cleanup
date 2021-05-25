#!/bin/sh

###############################################
# Purpose: Obtain a list of suitable replacement notebook images
#####
# Input: 
# 5-user-items: a list of vulnerable images with namespace + notebook name data in cluster.
# spawner_ui_config.yaml: From our kubeflow manifest, used as the update image candidate
#####
# Actions: curl the github repo and format the yaml
# Use 5-user-items and try to find a matching entry in the spawnerfile.
# If found, replace, if not, have the imagepath changed to an empty string
#####
# TODO: Install yq on this image. http://mikefarah.github.io/yq/ 
###############################################

curl -o 6-spawnerfile.yaml https://raw.githubusercontent.com/StatCan/kubeflow-manifest/master/kustomize/application/jupyter-web-app/configs/spawner_ui_config.yaml

# Format
yq e '.spawnerFormDefaults.image.options[]' 6-spawnerfile.yaml >> 6-sanctified-images.txt

#Replace the slashes with a semicolon to compare with 5-user-items.txt
sed -i 's/\//;/g' 6-sanctified-images.txt

#Returns the leading path ie) keep everything before the image tag
retrieve_tagless_path () {
  imagepath=${1%:*}
  echo $imagepath
}

# Going line by line in 5-user-items, compare with this 6-sanctified images and if you find a hit replace
cat 5-user-items.txt | 
while read -r line
do
  imagepath=$(echo $line | jq '.ImagePath' | tr -d '"')
  taglessimage="$(retrieve_tagless_path $imagepath)"
  # Now find the image in sanctified images, (will be empty if not found), meaning we will delete.
  newimage=$(grep -roE "$taglessimage[^ ]*" 6-sanctified-images.txt)
  echo $line | jq -c --arg replace "$newimage" '.ImagePath=$replace' >> 6-replacement-images.txt
done
