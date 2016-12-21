# set dbname to fix
dbname=<your database name>
/etc/init.d/mysql stop; sleep 5s;
cd /var/lib/mysql/$dbname
list=`ls *.MYI`; for i in $list; do myisamchk -r -f $i; done
/etc/init.d/mysql start
