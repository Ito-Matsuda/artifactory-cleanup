#!/bin/sh

#####################################################################################################################
# VULNERABILITIES FOR USER
#####################################################################################################################

# Step 1 Get the intersection of the two files. 
# Might want to change this to look at the get-notebook and then make the change in the JSON to make it easy 
# to use down the line (less file comparisons just to find where is where)
#awk 'NR==FNR{arr[$0];next} $0 in arr' 4C-formatted-impacted-artifacts.txt 2-notebook-a.txt >> 5-A-notebook-vuln.txt



#####################################################################################################################
# VULNERABILITIES FOR ADMIN
# Need to decide if these will automatically update
#####################################################################################################################

# Step X get a list of affected pods in the cluster. 
# Having said that I wouldn't want to be an admin recieving a ton of emails about some istio / vault vulnerability (these are in each notebook server)

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
sed 's/\//;/g' 2-notebook-images.txt | 
while read -r line
do
  sed -i "/$line/d" 5-kubectl-pods.txt
done

#At this point 5-kubectl-pods.txt contains information on images not used in notebook servers.

#Now do a comparison w/ 4C-formatted-impacted-artifacts.txt
# We want to keep in 5-kubectl-pods.txt what is in 4C. So remove anything not in 4C
#SED to / to ; for easy pattern matching
sed -i 's/\//;/g' 4C-formatted-impacted-artifacts.txt 

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
cat 5-A-notebook-vuln.txt | sort | uniq | 
while read -r line
do
   #Not-applicable as the notebook image (ex: jupyterlab-cpu) may be used in many notebooks across the cluster
   echo "{"\""Namespace"\"":"\""not-applicable"\"","\""Image"\"":"\""$line"\"","\""Name"\"":"\""not-applicable"\""}" >> admin-items.txt
done