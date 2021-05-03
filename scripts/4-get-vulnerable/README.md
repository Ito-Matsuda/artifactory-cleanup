STEP 4: Get list of images that are in violation.

# Input

4-violationscheck.json: The JSON file we send to artifactory xray to filter on what severity we are searching for. This currently looks for artifacts that have a 'critical' vulnerability (may need to change filter / this file).

# Process
Send a .json containing the query to search for in xray violations. Currently looks for `Critical` vulnerabilities. 
Using the output from that step, parse it into something useful (image paths) that we can use to compare with the image names present
in the cluster.

The following is possibly a *temporary* step as I'm not sure what the output on our artifactory deployment will be.
ie) it has the leading `default/` before the path

# Output

4-violations.json: The result of using 4-violationscheck.json. Difficult to use so we parse it into the next output file

4C-formatted-impacted-artifacts.txt: Parsed list of the images (their paths) that are afflicted with a Critical vulnerability


# Old thoughts / Ramblings
Should be able to be called on command. Will scan entire repo(?) and output to json list of bad images? 


Not sure how to get this running / scan for vulnerable images (xray?)
Then would need to get information on who is using that image and then sending some notif?

I am also guessing that we will have scanning as a part of our CI/CD process. So perhaps this is ran on the older images.
So again would use the output form 1-all-old-images and use the paths there to scan everything in that 'image' folder (ie the docker layers)
