#!/bin/sh

#Will be of form 
# kubectl patch Notebook notebookName --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value":"NEWIMAGE"}]' --namespace ...

