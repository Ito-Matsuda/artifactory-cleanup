#!/bin/bash
echo "hello world"

exit
#docker pull jfrog.aaw.cloud.statcan.ca/jose-play/busybox 2>&1 | 
#if grep -Fxq "Error response from daemon: unknown: Forbidden"
#then
#  echo "Hello world"
#fi

#######################################
#can do -q
value="busybox"
count=0
#value="bitnami/node"
until docker pull jfrog.aaw.cloud.statcan.ca/jose-play/$value 2>&1 | grep -m 1 "Pm\|Eron:"
do 
  echo "$count"
  sleep 1
  ((count++))
  if [ $count -eq 10 ]
    then
    break
  fi
  
done
count=0
echo $value
echo $count
