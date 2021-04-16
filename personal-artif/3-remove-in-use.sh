#!/bin/sh

# Taking the text file 2-artif and 2-sample-kubectl.txt
# Keep entries that are ONLY in fileA. 
# File C requires an ending newline for read in the next script to work properly
# awk 'NR==FNR{a[$0];next} !($0 in a)' fileB fileA > fileC
awk 'NR==FNR{a[$0];next} !($0 in a)' 2-sample-kubectl.txt 2-artif.txt > 3-to-delete.txt
