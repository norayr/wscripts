#!/bin/bash_
TMP=`mktemp`
TMP2=`mktemp`
DEIZ="days"

#w | sed '1,2d' | less > $TMP
w | grep days | less > $TMP
#sed -i 's/days//' $TMP
cat $TMP | sort -k 5 -n -r > $TMP2

#less $TMP2
#set -x
while read line
do
  days0=`echo $line | awk {' print $5 '}`
  #now lets check if string contains 'days' to make sure we took the right column
  if [[ "$days0" == *"$DEIZ"* ]]
  then
    days=${days0%days}  #extract the number of days
    if [  $days -ge 10 ]
    then
      user=`echo $line | awk {' print $1 '}`
      echo "user $user; days $days"
      if [[ "$user" != "root" ]]
      then
        pts=`echo $line | awk {' print $2 '}`
        TMP3=`mktemp`
        ps aux | grep ${pts} | grep -v grep > $TMP3
        while read line2
        do
          pid=`echo $line2 | awk {' print $2 '}`
          cmd=`echo $line2 | awk '{for(i=11;i<=NF;i++) printf $i" "; print ""}'`
          echo "killing pid: $pid ; user: $user ; cmd: ${cmd}"
          kill $pid
          #sleep 3
        done < $TMP3
        #echo "pkill -u $user"
      else
        echo "root has old sessions, ignoring"
      fi
    fi
  fi
done < $TMP2
