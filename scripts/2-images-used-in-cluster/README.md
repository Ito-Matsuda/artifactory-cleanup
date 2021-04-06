STEP 2

Using kubectl get a full list of images currently in use. Images here should NOT BE REMOVED from Artifactory.
We will not remove any images in use unless there is something like a vulnerability found. 

Even then we would need to migrate that user's image to an upgraded image (need to find this out)


Hopefully, we can use this in combination with the getting of the `manifest.json`'s older than X period. 