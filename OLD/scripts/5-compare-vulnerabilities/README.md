Step 5: Compares the images from 4-get-vulnerable with the notebook images and looks for any hits

# INPUT

2-kubectl-notebook.txt: All notebook user selected images 


2-notebook-images.txt: Used to prune down kubectl pods. 


5-kubectl-pods.txt: Every single image in the cluster. 


# PROCESS / Intermediate Files

user-items-image-list: Adds to `admin-items.txt` a list of images used by notebooks that are vulnerable. These are uniq'd. 


# OUTPUT

admin-items.txt: A list of images that need to be replaced (vulnerabilities were found). The information here could be sent
to the admin and let them determine how to upgrade said images. I'm not sure on how we'd look for more 'up to date' images.

user-items.txt: A list of images that need to be emailed to whoever owns the container at "namespace"
(Still need to get their email)

# OLD NOTES / RAMBLINGS
Gets the INTERSECTION of the two notebook images and the 4C-impacted... 
This might be easier to do with the 2-kubectl-notebook. and just modifying it. 
The 2-notebook-images was useful for the "do not delete these images" area in 3.