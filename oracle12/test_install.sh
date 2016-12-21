sh /tmp/database/runInstaller  oracle.install.option=INSTALL_DB_SWONLY \
   SECURITY_UPDATES_VIA_MYORACLESUPPORT=false \
   DECLINE_SECURITY_UPDATES=true \
   ORACLE_BASE=/u01/app/oracle \
   ORACLE_HOME=/u01/app/oracle/product/12.1.0.2/dbhome_1 \
   INVENTORY_LOCATION=/u01/app/oraInventory \
   SELECTED_LANGUAGES=en \
   oracle.install.db.InstallEdition=EE \
   UNIX_GROUP_NAME=oinstall \
   oracle.install.db.DBA_GROUP=dba \
   oracle.install.db.OPER_GROUP=oinstall \
   oracle.install.db.BACKUPDBA_GROUP=dba \
   oracle.install.db.DGDBA_GROUP=dba \
   oracle.install.db.KMDBA_GROUP=dba -silent -ignoreSysPrereqs -ignorePrereq -waitForCompletion

pth=/u01/app/oracle/product/12.1.0.2/dbhome_1/install/utl

# untested:
# one of the following to install to /usr/bin, not /usr/local/bin
# 0. set LBIN to /usr/bin in 
# /u01/app/oracle/product/12.1.0.2/dbhome_1/install/utl/rootmacro.sbs
#sed -i 's#LBIN=/usr/local/bin#LBIN=/usr/bin#' ${pth}/rootmacro.sbs

# or
# set OUI_SILENT=false
# in /u01/app/oracle/product/12.1.0.2/dbhome_1/install/utl/rootmacro.sh
# to get the question. 
# sed -i 's/OUI_SILENT=true/OUI_SILENT=false/' /u01/app/oracle/product/12.1.0.2/dbhome_1/install/utl/rootmacro.sh

