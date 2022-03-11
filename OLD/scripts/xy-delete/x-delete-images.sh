#!/bin/sh

#To delete, script MUST be called with the argument DELETE

URL="https://testjosez.jfrog.io/artifactory"

#oneDateToDelete=20210125

#let dateCompare=($(date +%s -d $currentDate)-$(date +%s -d $oneDateToDelete))/86400
#echo $dateCompare
#echo $timeLimit

#if (("$dateCompare" > "$timeLimit")); then
#    echo "greater than 30 days"
#  else
#    echo "not greater than 30 days"
#fi


#Get current date in Y/M/D
currentDate=$(date '+%Y%m%d')

timeLimit=30
#May need to change depending on the actual structure of the file containing the info
echo "Today's date is $currentDate"
sed 's/\//;/g' test.json |
while read -r line
do
  oldDate=$(echo $line | jq -c '.theDate' | tr -d '"')
  let dateCompare=($(date +%s -d $currentDate)-$(date +%s -d $oldDate))/86400
  if (("$dateCompare" > "$timeLimit")); then
    echo "Date:" $(echo $line | jq -c '.theDate' | tr -d '"') "greater than 30 days" 
    # echo "File to delete: " $(sed 's/;/\//g' $line | jq -c '.image' | tr -d '"')
  else
    echo "Date:" $(echo $line | jq -c '.theDate' | tr -d '"') "not greater than 30 days"
  fi
done


#OLD CODE

cat 3-to-delete.txt | 
while read -r line
do
  if [ "$1" = "DELETE" ]; then
    echo "DELETING..."
    curl -u myuser:password! -X DELETE $URL"/"$line
  else 
    echo "Would delete-->"$URL"/"$line >> x-dryrun-delete.txt
  fi
done