# Should use 5-user-items and go line by line and look for versions greater than "Version"
# The last bit of the image in artifactory is always the tag. 
#items.find({"name":{"$eq":"manifest.json"},"@docker.label.description":{"$eq":"something"}})
# i still want to have a `main` label. 
URL="https://testjosez.jfrog.io/artifactory/api/search/aql"

# Maybe this 'request' should change. 
# In that instead you change what's in the --> "archive.entry.path":{"$eq":"org/artifactory"}
# Because the path would stay the same to the tag (this falls through if the path / image name underwent a change).
# under which perhaps an ADMIN should be notified. 
# EX: 
#     default/docker-quickstart-local/my-docker-image/5eefshacode/
#     default/docker-quickstart-local/my-docker-image/delete1/
# Then compare by 'created date'?
# So for each vulnerable image in the cluster, use the path from it 
curl -u myuser:red! -X POST $URL -H "content-type: text/plain" -d @new-images-request.txt >> artifactory-get.json 

#Given something like below, format the image path to change the semicolon back to a /, then extract the part before the "colon"
# in image path. sort by created
# {"Namespace":"jose-matsuda","ImagePath":"...azurecr.io;jupyterlab-cpu:dee04..1","Name":"doubletestcheck","Version":"1.0.0"}
# {"Namespace":"jose-matsuda","ImagePath":"...azurecr.io;jupyterlab-cpu:dee04..1","Name":"changeimage","Version":"1.0.0"}


cat artifactory-get.json | jq -c '.results[] | {completepath: "\(.repo)/\(.path)"}' |
while read -r line
do
  echo $line | jq '.[]' |  tr -d '"' >> 6-new-image-list.txt
done 

# Should include something to catch if a suitable replacement image is not found then mention in an email yada yada. 

##Semantic versioning test  is 1-i.json
#items.find({"name":{"$eq":"manifest.json"},"@docker.label.version":{"$gt":"1.5.1"}, "path":{"$match":"my-docker-image/*"}})