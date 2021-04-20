violationscheck.json should be what is `POST`'d to /api/v1/violations.
--> hopefully the response would have what we need.
https://www.jfrog.com/confluence/display/JFROG/Xray+REST+API#XrayRESTAPI-GetViolations

*Im going to assume that the pagination part is optional

curl -u myuser:... -X POST $URL -H "Content-Type: application/json" -d @violationscheck.json >> vulnerabilities.json