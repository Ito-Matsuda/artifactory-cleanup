# artifactory-cleanup
Holds scripts for artifactory cleanup

General Stuff
Script A: Via Artifactory. get list of all images older than X period of time, say in list toDelete
Script B: Via kubectl. Get list of all images currently in use. Say in a list of ToKeep
Script C: Get all vulnerable images (not sure how do to yet) in list getOutOfHere
Script D: Remove any images in ToKeep that are in ToDelete

Script E: Add 'getOutOfHere' to 'ToDelete'
Script F: Run the list to delete everything.

The general run through of this may include A-F with D-F being if we have a vulnerability. 

# DOES NOT COUNT FOR THE CASE WHERE WE NEED TO "UPDATE" CURRENTLY RUNNING IMAGES
Maybe step C would create a list? Because if we just proceed with the delete then the kubectl or whatever we use may have 
no idea what XRAY identified as "vulnerable" since XRAY will no longer have access to said image.
Another way of doing that is to update any images whose tags are not found in artifactory and update it. 
(Will fail if the image NAME changes ala not the SHA that identifies it )



# IMPORTANT
it has been brought to my attention the following concerns;

I'm also not as convinced as {YouKnow} about the automatic background updating of vulnerable images.  It would be great, but I don't see how we do it without impacting user workloads
a near-term compromise could be that pruning images still works something like {toDelete} - {toKeep}, where {toKeep} would include any vulnerable images that are still running.  But then separately getOutOfHere would trigger some sort of eviction action where users are notified "notebook server X is using image Y which has been found to have a security vulnerability.  Please move this workload to a new image by date Z"

In Response to "If we delete an image in artifactory existing workloads should be fine right?"
Yeah I’m not sure what happens there. The edge case I can think of is if a workload gets rescheduled (say if the autoscaler shuts down a node and migrate existing work from that node to another one). If we’ve deleted the image, can it migrate successfully? My guess is no because it can’t pull the image, but maybe something fancy is going on there