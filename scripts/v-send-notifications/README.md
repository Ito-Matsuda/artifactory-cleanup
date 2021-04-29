STEP v: Send notifications of vulnerable images to the correct parties

Maybe use a python script? 

# Input

A) X-impacted-artifacts.txt: Parsed list of the images (their paths) that are afflicted with a Critical vulnerability. (still need to figure this 'default' thing out)

B) 2-kubectl-notebook.txt: From step 2, each _line_ is valid json containing the image name, notebook and namespace. 

C) 2-used-non-notebook-images.txt: From step 2. These are images used in the cluster but not attached to a notebook.

X) Some list that needs to get the 'updated' versions of the image, how we match on this I am undecided on.
Would I need to know things / separate based on the slashes? Ex) docker-quickstart-local/my-docker-image/latest 
I would need a query (to artifactory) to get younger images for sure. 

# Operations

In no particular order

## Notify the Admin of images in cluster with vulnerabilities

I) Get the intersection of A and C and produce a new list "affected-in-cluster"

II) Using a master admin email (or even slack notification) send them a message containing the contents of "affected-in-cluster"
letting them know that these deployed images are vulnerable

## Notify Users of their vulnerable notebooks. NEED TO FIND OUT HOW TO GET USER EMAILS STILL! 

I) Get the intersection of A and B. Can get user profile info using `kubectl describe profile jose-matsuda`

II) Query the database that maps the user's email to 

III) Send them an email containing information on how to update their image and that they have X days to update their notebook.


# Output

