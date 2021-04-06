# Base example of curling a rest endpoint 
# curl https://official-joke-api.appspot.com/random_joke >>  joke.txt
# {"id":222,"type":"general","setup":"What do you call a monkey in a mine field?","punchline":"A babooooom!"}

#Source https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-DeleteItem
#EXAMPLE Using an access token 
#curl -u myUser:<Token> -X PUT "http://localhost:8081/artifactory/my-repository/my/new/artifact/directory/file.txt" -T Desktop/myNewFile.txt


#The AQL is exposed by a REST API https://www.jfrog.com/confluence/display/JFROG/Artifactory+Query+Language
# old-images-request is what we will send

#fill in the blanks, modify old-images-request.txt as needed
curl -u myUser:<Token> -X POST -d @old-images-request.txt "someurlhere" >> image-list.json 
