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

while true; do
    read -r line < 6-replacement-images.txt 

    #Retrieve namespace in form "Namespace":"jose-matsuda"
    namespace='"Namespace":'$(echo $line | jq '.Namespace') 

    #Get list that contain that namespace. 
    grep $namespace 6-replacement-images.txt > g-one-namespace-file.txt

    echo "Sending emails... "
    userEmail=$(findUserEmail() $namespace)
    sendUserEmail() $userEmail $namespace

    # Remove the $namespace from the file
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

# Using the Namespace find out what the email address is. 
findUserEmail(){
    echo $1
}

# Construct the contents of the email and send it
sendUserEmail(){
    SUBJECT="Alert: Vulnerability found in namespace: $2"
    TO="tongster789@gmail.com tongthrow@gmail.com" #substitute with $1
    MESSAGE="One or more of your notebook servers has been found to be using a vulnerable image and have been patched or deleted."
    #Loop through g-one-namespace-file.txt
    while read -r jsonline; do
        #read imgpath nbname < <(echo $jsonline | jq -r '.ImagePath, .Name') # not working???
        nbName=$(echo $jsonline | jq -r '.Name')
        imgPath=$(echo $jsonline | jq -r '.ImagePath')
        
        # If imgPath is empty then the server was deleted.
        if [ -z "$imgPath" ] ; then
            MESSAGE=$MESSAGE$'\n'"Notebook named '$nbName' was deleted as there was no suitable update image"
        else
            MESSAGE=$MESSAGE$'\n'"Notebook named '$nbName' was upgraded to a safe image"
        fi
        
    done < g-one-namespace-file.txt
    #FULL SEND
    # echo "${MESSAGE}" | mail -s $SUBJECT $TO
}