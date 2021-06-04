#!/bin/sh

# This relies on the following being installed; ssmtp, mailutils.
# https://www.digitalocean.com/community/questions/how-to-send-emails-from-a-bash-script-using-ssmtp


# Email to USERS
SUBJECT="Alert: Vulnerability found in notebook server"
# TO has to be space separated
TO="tongthrow@gmail.com tongster789@gmail.com" 
#argument? would need to collect all the related info in one spot
MESSAGE="Hello we found some vulnerable stuff pls do something"

#Modify the message above somehow. 
echo $MESSAGE | mail -s $SUBJECT $TO


#ADMIN EMAIL
TO="tongster789@gmail.com" #list of admins or whatever
MESSAGE="The following images in the manifest are vulnerable and need to be updated asap."'\n'"$(cat 4-email-admin.txt)"
echo "$MESSAGE" | mail -s "Alert Notebook server has no viable update image" $TO
