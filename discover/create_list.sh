fourth=`seq 1 253`
ip="192.168.0."
for i in $fourth; do echo "$ip$i" >> ips.txt; done
