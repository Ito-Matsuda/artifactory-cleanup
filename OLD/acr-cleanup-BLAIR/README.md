# Jose Notes
So to adapt this, we just use the docker registry api instead of az acr.
There seem to be equivalents .

Obtain a list of repos 

https://docs.docker.com/registry/spec/api/#listing-repositories

Get the digests
https://github.com/distribution/distribution/issues/1565#issuecomment-202497218


# New stuff 
Using the digests delete the image

https://docs.docker.com/registry/spec/api/#deleting-an-image


# BLAIR ORIG NOTES

# images-in-use.txt

Brendan gave me this file; it's a list of
images (and their counts) that are actively
running in the cluster.


# fully-remove.txt

I read through the container registry and
spotted a bunch of development images which
should be removed entirely. I flagged them here.


# Old images in the registry

The scripts

	0-get-acr-images.sh
	1-get-image-manifests.sh
	2-get-outdated-images.sh

Do what one would expect, and they just write
json files into the json folder. They have to
be executed sequentially. The third script
produces a jsonlines file:

```
{ repo, timestamp , [tags], digest }
```

But with 
	- the 5 most recent images removed
	- only timestamps one month old (or more)

So this json file should be enough info to figure
out which images need to be removed.
