#set -x
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
RSH=/usr/bin/rsh
#this file should contain list of ip adresses
ips=`cat ips.txt`
#these are lists of rhel{4,5,6} to be populated from the hosts list.
list4=""; list5=""; list6=""; list7="";
os="lists"
mkdir -p $os
#looping through hosts to populate specific os lists.

for i in $ips
do
  tmp=`sudo nmap -O -v $i | grep Running | awk '{print $2}'`
  if [ "$tmp" = "" ]
  then
    printf "$i ${RED}OS not detected${NC}\n"
    echo "$i" >> $os/unknown.txt
  else
  
    fullHostName=`host $i | awk {'print $5'}`
    #now take the string before first occurence of dot
    hostName="$( cut -d '.' -f 1 <<< "$fullHostName" )";  
    macAddr=`arp $i | grep ether | awk {'print $3'}`
    line="$hostName     $macAddr      $i"
    printf " ${GREEN} $tmp ${NC} $line\n"  

    if [ "$tmp" = "Linux" ]
    then
       printf " ${GREEN} $tmp ${NC}\n"
       tmpline=`$RSH $hostName "cat /etc/issue | grep Linux"`
       osv0=`echo $tmpline | awk '{print $7}'`
       osv="${osv0%.*}"
       echo $osv
  
       if [ "$osv" -eq "4" ]
       then
         list4="$list4 $i"
         echo $line  >> $os/el4.txt
       elif [ "$osv" -eq "5" ]
       then
         list5="$list5 $i"
         echo $line  >> $os/el5.txt
       elif [ "$osv" -eq "6" ]
       then
         echo $line  >> $oslel6.txt
         list6="$list6 $i"
       elif [ "$osv" -eq "7" ]
       then
         echo $line  >> $os/el7.txt
         list7="$list7 $i"
       else
         echo $line >> $os/unknown_linux.txt
       fi
    else
        printf "$line ${GREEN} $tmp ${NC}\n"
        echo "$line" >> $os/$tmp
    fi
  fi
done

#now we have specific os lists


