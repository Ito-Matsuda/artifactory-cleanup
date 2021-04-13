#!/bin/sh

jq -r '.[]' json/0-image-list.json |
	while read line; do
		az acr repository show-manifests --repository $line -n k8scc01covidacr |
			jq -c --arg repo $line '{ "repo" : $repo, "manifest" : . }'
	done | tee json/1-image-manifests.json
