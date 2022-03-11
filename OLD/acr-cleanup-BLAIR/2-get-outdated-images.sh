#!/bin/sh

# All images in the output are at least 5 iterations behind.

# to be EXTRA safe, we won't delete anything unless it's over a month old

ONE_MONTH_AGO=$(date --date='-1 month' +'%Y-%m-%d')

jq -c --arg BEFORE $ONE_MONTH_AGO '.repo as $r
   | .manifest
   # remove the 5 most recent images
   | sort_by(.timestamp)
   | reverse
   | del(.[0,1,2,3,4])
   # flatten and sticker with the repo
   | .[]
   | { "repo" : $r, "timestamp" : .timestamp, "tags" : .tags, "digest" : .digest }
   # Select images older than our timelimit
   | select(.timestamp <= $BEFORE)
' json/1-image-manifests.json |
	tee json/2-outdated-images.json
