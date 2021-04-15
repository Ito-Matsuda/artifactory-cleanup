STEP 3

Create a json of `images-to-delete` whose contents are from `image-list.json` minus `keep-images.json`.
Where again hopefully the `path` from `image-list.json` will match up nicecly with the names provided by `keep-images.json`(kubectl)

JSON contains repo, path (hoping something like: jupyterlab/dee04931), and name (manifest.json)

Process: 
1) Change the output from Step 2 from something like repo/whatever/jupyterlab-cpu:someTag to repo/whatever/jupyterlab-cpu/someTag
2) Using output from Step 1 combine the repo + path. 
3) Remove any items found in both steps above (meaning said image is in use)