#!/bin/sh

#To delete, script MUST be called with the argument DELETE

URL="https://testjosez.jfrog.io/artifactory"

cat 3-to-delete.txt | 
while read -r line
do
  if [ "$1" = "DELETE" ]; then
    echo "DELETING..."
    curl -u myuser:password! -X DELETE $URL"/"$line
  else 
    echo "Would delete-->"$URL"/"$line >> 5-dryrun-delete.txt
  fi
done