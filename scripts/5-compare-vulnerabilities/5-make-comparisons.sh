#!/bin/sh

#####################################################################################################################
# USER/ADMIN SHARED FORMATTING 
# Avoid any escaping problems by going from `\` --> `;`
sed -i 's/\//;/g' 4C-formatted-impacted-artifacts.txt 
sed -i 's/\//;/g' 2-notebook-images.txt
#####################################################################################################################


#####################################################################################################################
# VULNERABILITIES FOR USER
# Returns a user-items.txt containing impacted images.
#####################################################################################################################

# Avoid escaping problems and match up to impacted artifacts
sed 's/\//;/g' 2-kubectl-notebook.txt |
while read -r line
do
  # extract the image from the file, trim the quotes, and replace the : with a ;
  imageCheck=$(echo $line | jq -c '.ImagePath' | tr -d '"' | sed 's/:/;/g')
  # Look for the image in the imapacted artifacts and if found print the line to the list. 
  if grep -Fxq "$imageCheck" 4C-formatted-impacted-artifacts.txt 
  then
     echo $line >> user-items.txt
  fi
done

#####################################################################################################################
# VULNERABILITIES FOR ADMIN
# Need to decide if these will automatically update
#####################################################################################################################

# Step X get a list of affected pods in the cluster. 
# Having said that I wouldn't want to be an admin recieving a ton of the same info about some istio / vault vulnerability (these are in each notebook server)

#Declare Variables that indicate that an image is vulnerable. These will be for the other images inside the notebook (not the jupyterlab etc)
# or are shared across many pods so as to not flood the admin with notifications. 
# Discuss this idea... 
ISTIO_VULN=false
VAULT_VULN=false

# kubectl get pods --namespace jose-matsuda -o json | jq -c '.items[] | {Namespace:(.metadata.namespace), Image:(.spec.containers[].image), Name:(.spec.containers[].name)}' > 5-kubectl-pods.txt

# Sed the slashes to semicolons (may want to change back to slashes after comparison)
sed -i 's/\//;/g' 5-kubectl-pods.txt

#Take out images used in notebooks (since there may be many in use) 
# Change to semicolon to prevent escaping in the 'sed'
cat 2-notebook-images.txt | 
while read -r line
do
  sed -i "/$line/d" 5-kubectl-pods.txt
done

#At this point 5-kubectl-pods.txt contains information on images not used in notebook servers.

#Now do a comparison w/ 4C-formatted-impacted-artifacts.txt
# We want to keep in 5-kubectl-pods.txt what is in 4C. So remove anything not in 4C

cat 5-kubectl-pods.txt | 
while read -r line
do
  # extract the image from the file, trim the quotes, and replace the : with a ;
  imageCheck=$(echo $line | jq -c '.Image' | tr -d '"' | sed 's/:/;/g')
  # Look for the image in the imapacted artifacts and if found print the line to the list. 
  if grep -Fxq "$imageCheck" 4C-formatted-impacted-artifacts.txt 
  then
     echo $line >> admin-items.txt
  fi
done 

# Need to do add back in the images used in notebooks (but just one of them each. don't have tens of jupyterlab-cpu if it's the same image)
cat user-items.txt | 
while read -r line
do
  echo $line | jq -c '.ImagePath'| tr -d '"' | sed 's/:/;/g' >> user-items-image-list.txt
done

cat user-items-image-list.txt | sort | uniq |
while read -r line
do
   #Not-applicable as the notebook image (ex: jupyterlab-cpu) may be used in many notebooks across the cluster
   echo "{"\""Namespace"\"":"\""not-applicable"\"","\""Image"\"":"\""$line"\"","\""Name"\"":"\""not-applicable"\""}" >> admin-items.txt
done