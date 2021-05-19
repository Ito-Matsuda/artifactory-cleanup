#!/bin/sh

# Using https://raw.githubusercontent.com/StatCan/kubeflow-manifest/master/kustomize/application/jupyter-web-app/configs/spawner_ui_config.yaml
# as an "good image" to update to. 

#Testing grounds delete these later/ just a cleanup
rm 6-sanctified-images.txt
rm 6-spawnerfile.yaml
# End testing grounds

curl -o 6-spawnerfile.yaml https://raw.githubusercontent.com/StatCan/kubeflow-manifest/master/kustomize/application/jupyter-web-app/configs/spawner_ui_config.yaml

# Now have to format that spawnerfile.yaml
# Use yq? http://mikefarah.github.io/yq/ (need to install this on image)
yq e '.spawnerFormDefaults.image.options[]' 6-spawnerfile.yaml >> 6-sanctified-images.txt

#Replace the slashes with a semicolon to compare with 5-user-items.txt
sed -i 's/\//;/g' 6-sanctified-images.txt

#Create a function that returns the leading path ie) keep everything before the image tag
retrieve_tagless_path () {
  imagepath=${1%:*}
  echo $imagepath
}

# Going line by line in 5-user-items, compare with this 6-sanctified images and if you find a hit replace
cat 5-user-items.txt | 
while read -r line
do
  #First things first I need just the ImagePath
  echo $line
  imagepath=$(echo $line | jq '.ImagePath' | tr -d '"')
  taglessimage="$(retrieve_tagless_path $imagepath)"
  # Now find the image in sanctified images, (will be empty if not found), meaning we will  just delete.
  newimage=$(grep -roE "$taglessimage[^ ]*" 6-sanctified-images.txt)
  echo $newimage
  echo $line | jq --arg replace "$newimage" '.ImagePath=$replace'
done


#MYVAR="/var/cpanel/users/joebloggs:DNS9=domain.com" 
#NAME=${MYVAR%:*}  # retain the part before the colon
#echo $NAME

#grep -roE 'k8scc01covidacr.azurecr.io;jupyterlab-cpu[^ ]*' 6-sanctified-images.txt

#cat temp.json | jq --arg newval "$xd" '.otherStuff=$newval'
# {
#  "Comment": "comment",
#  "test": {
#    "enabled": true
#  },
#  "enabled": true,
#  "otherStuff": "newvalue",
#  "otherStuff2": "blah",
#  "otherStuff3": "blah"
#}
