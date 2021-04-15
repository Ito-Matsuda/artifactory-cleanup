#!/bin/sh

# Taking the text file 2-artif and 2-sample-kubectl.txt
# grep -Fvxf 2-sample-kubectl.txt 2-artif.txt --> doesnt work well
# awk 'NR==FNR{a[$0];next} !($0 in a)' fileB fileA
awk 'NR==FNR{a[$0];next} !($0 in a)' 2-sample-kubectl.txt 2-artif.txt > 3-to-delete.txt
