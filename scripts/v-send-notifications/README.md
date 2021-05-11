STEP v: Send notifications of vulnerable images to the correct parties

Maybe use a python script? 

# Input

A) admin-items: from step 5 just send this list to the admin. Has information on what containers, what images, and what namespace the vulnerability is found in.

# Operations

In no particular order

## Notify Users of their vulnerable notebooks. NEED TO FIND OUT HOW TO GET USER EMAILS STILL! 

I) Get the intersection of A and B. Can get user profile info using `kubectl describe profile jose-matsuda`

II) Query the database that maps the user's email to 

III) Send them an email containing information on how to update their image and that they have X days to update their notebook.


# Output


# Sample Email Text

## Generic ADMIN vulnerability notice email
Hello, this is an email to inform you that the following list of images have been found to contain critical vulnerabilities. 

~display info here

## Generic USER vulnerability notice email.
Hello, this is an email to inform you that a notebook server of yours has been found to contain a critical vulnerability.
You will need to update your notebook server `name here` to a newer version.
To do this you do `command here should include which image to update to` 
Please note that during the update any running processes will stop and would need to be restarted.  

Please update your notebook by the end of X or else it will be automatically updated and restarted. 

If you have any questions feel free to contact `person` here

## Generic USER vulnerability notice email part two (but no image to update to) 
Hello, this is an email to inform you that a notebook server of yours has been found to contain a critical vulnerability.
You will need to update your notebook server `name here` to a newer version. However our system has not found a suitable image to update to.
This could be because of an image change or a fix has not yet been deployed. Please be patient and you will get another email once a suitable image has been found and will tell you how to update.

- Is this even wanted? Should we let them know or just keep it under wraps if there's no suitable next image to update to.