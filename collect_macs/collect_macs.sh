#set -x
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
RSH=/usr/bin/rsh
#this file should contain list of hosts
hosts=`cat hosts.txt`
cmd="cat /etc/issue | grep Linux"
for i in $hosts
do
  if ping -c 1 $i &> /dev/null
  then
    printf "$i		${GREEN}pingable${NC}\n"
    hostName=$i
    macAddr=`arp $i | grep ether | awk {'print $3'}`
    echo "mac:			$macAddr"
    ip=`getent hosts $i | awk '{ print $1 }'`
    echo "ip:		$ip"
    echo ""
    line="$hostName	$macAddr	$ip"
    echo $line
    echo $line >> kickstart_info.txt
  else
    printf "$i ${RED}not pingable${NC}\n"
    echo $i >> unpingable.txt
  fi
  echo "_______________________________________"
done

