#!/bin/bash 
#arguments
if [ $# -eq 0 ]; then
    echo "No arguments provided"
    echo "usage: scriptname username space"
    exit 1
fi

user=$1
space=$2
###test
#set -x
#user=anizak
#space=am04dwt3p060

#constants
location="/remote/am04fsmon/AM04/SG/data"

###########


uid=`getentx passwd $user | awk -F ":" {' print $3 '}`

#action

cd $location/$space/lists

all_files=`find . | grep $uid`
#echo $all_files

uuid=`uuidgen`
mkdir /tmp/$uuid

for i in $all_files
do
num=`echo $i | awk -F "/" {' print $2'}`
cp $i /tmp/$uuid/${num}_${uid}.gz

done


cd /tmp/$uuid
gunzip *


echo $user $space
for j in `ls`
do
  k=`wc -l $j`
  echo $k
  #echo "$j $k"
done

function proceed(){

cd /tmp/$uuid
for l in `ls`
do
  /root/bin/delete_files.sh $l
done

}


read -p "Continue (y/n)?" choice
case "$choice" in 
  y|Y ) proceed;;
  n|N ) echo "stopping";;
  * ) echo "invalid";;
esac
