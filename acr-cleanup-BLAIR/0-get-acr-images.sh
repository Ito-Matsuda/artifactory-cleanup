#!/bin/sh

mkdir -p json

az acr repository list -n k8scc01covidacr > json/0-image-list.json
