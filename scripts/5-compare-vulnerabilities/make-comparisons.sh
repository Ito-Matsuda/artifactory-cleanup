#!/bin/sh

# Step 1 Get the intersection of the two files. 
# Might want to change this to look at the get-notebook and then make the change in the JSON to make it easy 
# to use down the line (less file comparisons just to find where is where)
#awk 'NR==FNR{arr[$0];next} $0 in arr' 4C-formatted-impacted-artifacts.txt 2-notebook-a.txt >> 5-A-notebook-vuln.txt




# Step X get a list of affected pods in the cluster. 
# Just run another kubectl here that has the info 
# Having said that I wouldn't want to be an admin recieving a ton of emails about some istio / vault vulnerability (these are in each notebook server)

#Declare Variables that indicate that an image is vulnerable. These will be for the other images inside the notebook (not the jupyterlab etc)
# or are shared across many pods so as to not flood the admin with notifications. 
ISTIO_VULN=false
VAULT_VULN=false

# kubectl get pods --namespace jose-matsuda -o json | jq -c '.items[] | {Namespace:(.metadata.namespace), Image:(.spec.containers[].image), Name:(.spec.containers[].name)}' > 5-kubectl-pods.txt

#should take out images from the user notebook images, but will still notify admin that say jupyterlab-xyz is vulnerable 
##use the output from the first step in make-comparisons (the intersection of the running notebooks + vulnerable) 
# Loop through each line in 2-notebook and get rid of lines containing it.
cat 2-notebook-images.txt | 
while read -r line
do
  awk "!/$line/" 5-kubectl-pods.txt > hello.txt
done

#failed ones for this removal thing 
# # grep -Fv "$line" 5-kubectl-pods.txt > newfile.txt
# # sed "/\$line/d" 5-kubectl-pods.txt

#while IFS="" read -r p || [ -n "$p" ]
#do 
#  printf '%s\n' "$p" | xargs 
#done < 2-notebook-images.txt



#Now do a comparison w/ 4C-formatted-impacted-artifacts.txt
#cat 5-kubectl-pods.txt | jq -c '.Image'

# Need to do 