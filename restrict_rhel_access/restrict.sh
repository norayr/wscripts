set -x
# this script will rsh to linux machines and lockdown access by specified group, groups, usernames.
# grpname variable should contain groups and user names who are allowed to login, separated by whitespaces.
GRPNAME="examplegroup exampleuser"

# command locations on my rhel4 host.
RSH=/usr/bin/rsh
RCP=/usr/kerberos/bin/rcp
SED=/bin/sed

# temporary directory
TMP=tmp

if [ ! -d "$TMP" ]; then
  mkdir $TMP
fi

#call the other module to get specific os lists
source categorize_rhel.sh

sauth=$TMP/system-auth
pauth=$TMP/password-auth

for i in $list4
do
   # add the line
   # account     required      pam_access.so
   # in to the account section of /etc/pam.d/system-auth file.
   $RCP $i:/etc/pam.d/system-auth tmp/
   #sed -i 's/account     required      pam_unix.so/account     required      pam_access.so\naccount     required      pam_unix.so/g' ${sauth}
   sed -i 's/account     required      \/lib\/security\/\$ISA\/pam_unix.so/account     required      pam_access.so\naccount     required      \/lib\/security\/\$ISA\/pam_unix.so/g' ${sauth}
   $RCP $i:/etc/security/access.conf $TMP/ 
   echo "- : ALL except root noch ashko $GRPNAME : ALL" >> $TMP/access.conf
   read line
   $RCP ${sauth}  $i:/etc/pam.d/system-auth
   #$RCP $TMP/access.conf $i:/etc/security/access.conf
done

for i in $list5
do
   # add the line
   # account     required      pam_access.so
   # in to the account section of /etc/pam.d/system-auth file.
   $RCP $i:/etc/pam.d/system-auth tmp/
   sed -i 's/account     required      pam_unix.so/account     required      pam_access.so\naccount     required      pam_unix.so/g' ${sauth}
   $RCP $i:/etc/security/access.conf $TMP/
   echo "- : ALL except root noch ashko $GRPNAME : ALL" >> $TMP/access.conf
   read line
   $RCP ${sauth}  $i:/etc/pam.d/system-auth
   #$RCP $TMP/access.conf $i:/etc/security/access.conf 
done

for i in $list6
do
   # add the line
   # account     required      pam_access.so
   # in to the account section of /etc/pam.d/system-auth file.
   $RCP $i:/etc/pam.d/system-auth tmp/
   $RCP $i:/etc/pam.d/password-auth tmp/
   sed -i 's/account     required      pam_unix.so/account     required      pam_access.so\naccount     required      pam_unix.so/g' ${sauth}
   sed -i 's/account     required      pam_unix.so/account     required      pam_access.so\naccount     required      pam_unix.so/g' ${pauth}
   $RCP $i:/etc/security/access.conf $TMP/
   echo "- : ALL except root noch ashko $GRPNAME : ALL" >> $TMP/access.conf
   read line
   $RCP ${sauth}  $i:/etc/pam.d/system-auth
   $RCP ${pauth}  $i:/etc/pam.d/password-auth
   #$RCP $TMP/access.conf $i:/etc/security/access.conf 
done


