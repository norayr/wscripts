#!/bin/bash
set -x
# database names to backup
DBS="databasename0 databasename1 databasename2"
# where to store
PRFX="/home/bak"
# date in the format convenient for backup file name.
DT=`date +%F`
# old date
#ODT=`date -d "yesterday 13:00 " + %F`
ODT=`echo -e "$(TZ=GMT+30 date +%Y-%m-%d)\n$(TZ=GMT+20 date +%Y-%m-%d)" | grep -v $(date +%Y-%m-%d) | tail -1`
mkdir $PRFX/$DT
mkdir $PRFX/$DT/sql
for i in $DBS
do
mysqldump -p<PASSWORD> $i | gzip > $PRFX/$DT/sql/$i.sql.gz
done
# remove previous backup.
rm -rf $PRFX/$ODT
