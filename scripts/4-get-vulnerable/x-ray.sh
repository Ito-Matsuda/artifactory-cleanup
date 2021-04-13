#USING the rest api trigger a scan and get list of vulnerable images (any vulnerable layer)
#https://www.jfrog.com/confluence/display/JFROG/Xray+REST+API#XrayRESTAPI-ScanArtifact
#URL may look something like http://ARTIFACTORY_SERVER_HOSTNAME:8082/xray/api/v1

#Also can configure a repo to block artifacts???
#https://jfrog.com/article/download-blocking/   https://jfrog.com/screencast/jfrog-xray-securing-your-builds-and-artifact-downloads/ 
# As artifacts are brought in, they are scanned, and then you can apply a block policy to prevent downloads. If something is already running then it would not
# block the download, but if a workload needs to be rescheduled does it need to redownload the data (which could now be blocked?) if so thats bad. 

#need to find out how to get the stuff
