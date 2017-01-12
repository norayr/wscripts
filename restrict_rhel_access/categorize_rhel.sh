RSH=/usr/bin/rsh
#this file should contain list of hosts
hosts=`cat hosts.txt`
#these are lists of rhel{4,5,6} to be populated from the hosts list.
list4=""; list5=""; list6="";

#looping through hosts to populate specific os lists.

for i in $hosts
do
  tmpline=`$RSH $i "cat /etc/issue | grep Linux"`
  osv0=`echo $tmpline | awk '{print $7}'`
  osv="${osv0%.*}"
  echo $osv
  
  if [ "$osv" -eq "4" ]
  then
    list4="$list4 $i"
  elif [ "$osv" -eq "5" ]
  then
    list5="$list5 $i"
  elif [ "$osv" -eq "6" ]
  then
    list6="$list6 $i"
  fi
done

#now we have specific os lists


