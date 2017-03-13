fourth=`seq 1 253`
ip="10.0.0."
for i in $fourth; do echo "$ip$i" >> ips.txt; done
