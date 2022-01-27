#!/bin/bash
#User input section
echo "-----------------------------------------"
tput setaf 1; echo "Files to chose from:";tput sgr0
ls *.tex
echo "-----------------------------------------"
tput setaf 2;echo -n "input file to compile: ";tput sgr0
read texfile
pdflatex $texfile


#Open PDF in evince
read -p "Open PDF in evince ? (y/n)?" CONT
if [ "$CONT" = "y" ]; then
  filewoext=`echo "$texfile" | cut -d'.' -f1`
  evince $filewoext.pdf&
fi
#Open library in code
read -p "Open library in code? (y/n)?" CONT
if [ "$CONT" = "y" ]; then
  code .;
fi


#Auto compile feature
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
 
