#!/bin/sh

mkdir -p json

#az acr repository list -n k8scc01covidacr > json/0-image-list.json
# https://docs.docker.com/registry/spec/api/#listing-repositories
# GET /v2/_catalog
# or the equivalent is https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-ListDockerRepositories

