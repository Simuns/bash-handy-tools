#!/bin/bash
echo "-----------------------------------------"
tput setaf 1; echo "Files to chose from:";tput sgr0
ls *.tex
echo "-----------------------------------------"
tput setaf 2;echo -n "input file to compile: ";tput sgr0
read texfile
pdflatex $texfile
checksum1=$(md5sum $texfile | cut -d " " -f1)
checksum2=$checksum1
echo "$checksum1 = $checksum2"
while true; do  
  if [ "$checksum1" = "$checksum2" ]
  then 
    sleep 2
    checksum1=$(md5sum $texfile | cut -d " " -f1)
  else
    pdflatex $texfile
    checksum2=$checksum1
  fi 
done
 
