#!/bin/sh

# Called when there is no possible image to update to. 
delete_notebook_server () {
  notebookname=${1}
  usernamespace=${2}
  deletecommand="kubectl delete notebook $notebookname --namespace $usernamespace"
  echo $deletecommand
  eval $deletecommand
  #In this event the "someuser" is meant to represent a user created notebook image
}

#Loop through 6-replacement-images.txt
# If the 'ImagePath' is not empty then do stuff
cat 6-replacement-images.txt | 
while read -r line
do
  #First things first I need just the ImagePath. Change the semicolon from previous comparison back to /
  imagepath=$(echo $line | jq '.ImagePath' | tr -d '"' | tr ";" /)
  # Following are sanitized from creation step, notebook names can only contain lowercase alphanumeric and '-'
  namespace=$(echo $line | jq '.Namespace' | tr -d '"')
  name=$(echo $line | jq '.Name' | tr -d '"')
  if [ -z "${imagepath}" ]; then
     # We don't have a suitable update image.
     # Delete the notebook
     delete_notebook_server $name $namespace
     continue
  fi
  runpatch="kubectl patch notebook $name --type='json' -p='[{\"op\": \"replace\", \"path\": \"/spec/template/spec/containers/0/image\",\"value\":\"$imagepath\"}]' --namespace $namespace"
  echo $runpatch
  eval $runpatch
done
