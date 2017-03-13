#detects OS and writes to os/osname files

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

mkdir -p os
rm -f os/*

while read line
do

if [ "$line" != "" ]
then
   printf "$line: ";
   tmp=`sudo nmap -O -v $line | grep Running | awk '{print $2}'`


   if [ "$tmp" = "" ]
   then
     printf " ${RED}OS not detected${NC}\n"
	 echo "$line" >> os/unknown.txt
   else
     printf " ${GREEN} $tmp ${NC}\n"
	 echo "$line" >> os/$tmp
   fi
fi

done < ips.txt


