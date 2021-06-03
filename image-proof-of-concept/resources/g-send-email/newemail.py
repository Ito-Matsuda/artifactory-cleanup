# https://github.com/kootenpv/yagmail
# https://support.google.com/a/answer/166852
# https://www.gmass.co/blog/you-can-now-send-10000-emails-with-gmass-and-gmail/ 
# (500 emails per day, 100 addresses per email) but really each address in an email counts
# so can only send max 5 emails with 100 addresses. set up multiple gmail accounts? i dont want that. 


#might not actually use this. 
# https://netcorecloud.com/tutorials/linux-send-mail-from-command-line-using-smtp-server/ 
# --> we have our own SMTP thing? Amazon AWS SES? (

import yagmail

def send_email_test():
    #Using app password
    yagmail.register('@gmail.com','')
    yag = yagmail.SMTP('@gmail.com')
    ccz = [] #must be a list loop through whatever thing we have to send emails
    ccz.append('jose@.ca')
    ccz.append('.ca')
    subject = 'New Subject test'
    body = 'This is obviously the body'
    print("sup")
    #yag.send(bcc = ccz, subject = subject, contents = body)

# Called when 4-email-admin.txt is non empty. 
# python -c 'import newemail; newemail.send_email_admin()'
def send_email_admin():
    print("Sending an email to admin")
    yagmail.register('@gmail.com','')
    yag = yagmail.SMTP('@gmail.com')
    adminlist = []
    adminlist.append('@queensu.ca') # any other admins go here in some list. 
    subject = 'Hello admin'
    body = 'Vulnerabilities on a manifest image have been found. Please update them asap. The impacted images are in the attachment.'
    #yag.send(bcc = adminlist, subject = subject, contents = body, attachments=['4-email-admin.txt'])

def main():
    send_email_test()

if __name__ == "__main__":
    main()