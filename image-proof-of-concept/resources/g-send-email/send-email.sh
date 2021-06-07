#!/bin/bash

###############################################
# Purpose: Send emails to ADMIN and USERS
#####
# Input: Text file containing vulnerable provisioned notebooks for admins
# 6-replacement images to let the user know about what notebook servers were affected. 
#####
# Actions: API call to Artifactory with a .txt file to get a JSON
# Retrieves just the image paths for simple comparison with kubectl
#####
###############################################

# This relies on the following being installed; ssmtp, mailutils.
# SSMTP conf path /etc/ssmtp/ssmtp.conf
# https://www.digitalocean.com/community/questions/how-to-send-emails-from-a-bash-script-using-ssmtp

# ADMIN EMAIL
# List of admins, emails separated by space, "email1@blah email2@blah ..."
TO="tongster789@gmail.com" 
MESSAGE="The following images in the manifest are vulnerable and need to be updated asap."'\n'"$(cat 4-email-admin.txt)"
#Comment out for now to test things
#echo "$MESSAGE" | mail -s "Alert vulnerable images in manifest has no viable update image" $TO


# Email to USERS
SUBJECT="Alert: Vulnerability found in notebook server" #This stays constant
TO="tongthrow@gmail.com tongster789@gmail.com" # or throw this in a loop. 
MESSAGE="Hello we found some vulnerable stuff pls do something"

#Modify the message above somehow. \
# comment out for now to test parsing the files 
#echo $MESSAGE | mail -s $SUBJECT $TO

while true; do
    read -r line < 6-replacement-images.txt 

    #Retrieve namespace in form "Namespace":"jose-matsuda"
    namespace='"Namespace":'$(echo $line | jq '.Namespace') 

    #Get list that contain that namespace. 
    grep $namespace 6-replacement-images.txt > g-one-namespace-file.txt

    # Act on that list somehow (send emails etc. )
    echo "Sending emails... "

    # Remove the $namespace from the file (should be with -i)
    sed -i "/$namespace/d" 6-replacement-images.txt
    # Remove the temporary one-namespace file (so it can be re-written)
    rm g-one-namespace-file.txt
    
    #Exit the loop (there's nothing left in the text file)
    read -r completion < 6-replacement-images.txt
    if [ -z "$completion" ] ; then
        echo "Finished"
        break
    fi
done
