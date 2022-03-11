Step H: Get some replacement images.

How do I determine what a suitable replacement image is? 
IDEAS:
Use image labels? 

In a .txt named 'fileA.txt' `items.find({"name":{"$eq":"manifest.json"},"@docker.label.description":{"$eq":"something"}})`
`curl -u myuser:red! -X POST $URL -H "content-type: text/plain" -d @fileA.txt`

Produces 

```
{
"results" : [ {
  "repo" : "docker-quickstart-local",
  "path" : "withtags/latest",        
  "name" : "manifest.json",
  "type" : "file",
  "size" : 943,
  "created" : "2021-05-03T15:47:24.310Z",
  "created_by" : "tongster789@gmail.com",
  "modified" : "2021-05-03T15:47:24.248Z",
  "modified_by" : "tongster789@gmail.com",
  "updated" : "2021-05-03T15:47:24.313Z"
} ],
"range" : {
  "start_pos" : 0,
  "end_pos" : 1,
  "total" : 1
}
}
```


# OLD RAMBLINGS

`curl -u myuser:redacted! https://testjosez.jfrog.io/artifactory/api/storage/docker-quickstart-local/withtags/latest/manifest.json?properties`

```
{
	"properties": {
		"artifactory.content-type": ["application/vnd.docker.distribution.manifest.v2+json"],
		"docker.label.description": ["something"],
		"docker.label.version": ["1.0"],
		"docker.manifest": ["latest"],
		"docker.manifest.digest": ["sha256:7030914c94a143363fe360000b2afef1803cd069802a46c259a907d870c71b49"],
		"docker.manifest.type": ["application/vnd.docker.distribution.manifest.v2+json"],
		"docker.repoName": ["withtags"],
		"sha256": ["7030914c94a143363fe360000b2afef1803cd069802a46c259a907d870c71b49"]
	},
	"uri": "https://testjosez.jfrog.io/artifactory/api/storage/docker-quickstart-local/withtags/latest/manifest.json"
}
``` 

Then a cool ` jq '.properties."docker.label.version"' ` and comparisons?

Using a list from 4 that contains a list of vulnerable images used by a notebook in the cluster. 

Will give this data to the end notebook user to let them know an option for updating.