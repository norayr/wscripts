#set -x
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
RSH=/usr/bin/rsh
#this file should contain list of hosts
ips=`cat ips.txt`
#these are lists of rhel{4,5,6} to be populated from the hosts list.
list4=""; list5=""; list6=""; list7="";
os="results"
mkdir -p $os
#looping through hosts to populate specific os lists.
cmd="cat /etc/issue | grep Linux"
for i in $ips
do
  if ping -c 1 $i &> /dev/null
  then
    printf "$i		${GREEN}pingable${NC}\n"
    fullHostName=`host $i | awk {'print $5'}`
    #now take the string before first occurence of dot
    hostName="$( cut -d '.' -f 1 <<< "$fullHostName" )";  
    echo "hostname:		$hostName"
    macAddr=`arp $i | grep ether | awk {'print $3'}`
    echo "mac:			$macAddr"
    echo ""
    line="$hostName	$macAddr	$i"
    echo $line
       tmpline=`$RSH $hostName "cat /etc/issue | grep Linux"`
       echo "rsh_output: $tmpline"
       if [ "$tmpline" != "" ]
       then	       
               printf "$i ${GREEN}rshable${NC}\n"
	       dstr=`echo $tmpline | awk '{print $1}'`
	       osv0=`echo $tmpline | awk '{print $7}'`
	       osv="${osv0%.*}"
	       echo "distr:			$dstr"
	       echo "os ver:			$osv"
	       if [ "$dstr" == "Red" ] 
	       then
		  if [ "$osv" -eq "4" ]
		  then
		    echo $line  >> $os/el4.txt
		  elif [ "$osv" -eq "5" ]
		  then
		    echo $line  >> $os/el5.txt
		  elif [ "$osv" -eq "6" ]
		  then
		    echo $line  >> $osl/el6.txt
		  elif [ "$osv" -eq "7" ]
		  then
		    echo $line  >> $os/el7.txt
		  else
		    echo $line >> $os/el_unknown.txt
		  fi
	       elif [ "$dstr" == "Welcome" ]
	       then
		   if [ "$osv" -eq "9" ]
		  then
		    echo $line  >> $os/suse9.txt
		  elif [ "$osv" -eq "10" ]
		  then
		    echo $line  >> $os/suse10.txt
		  elif [ "$osv" -eq "11" ]
		  then
		    echo $line  >> $osl/suse11.txt
		  elif [ "$osv" -eq "12" ]
		  then
		    echo $line  >> $os/suse12.txt
		  else
		    echo $line >> $os/suse_unknown.txt
		  fi
	       else
		 echo $line >> $os/other.txt 
	       fi
       else
          printf "$i ${RED}not rshable${NC}\n"
          echo $line >> $os/unrshable.txt
       fi
  else
    printf "$i ${RED}not pingable${NC}\n"
    echo $i >> $os/unpingable.txt
  fi
  echo "_______________________________________"
done

#now we have specific os lists


