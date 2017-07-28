### IMPORT
source ./out.sh
#########

# expects full paths:
# first param is where to link
# second param is a broken link to fix   

function fixLink
{
   if [ -L $2 ] ; then
     if [ -e $2 ] ; then
        OutRedLine "ACHTUNG "
        OutLine "${tmplnk} is a good link, did you remove the link destination?"
     else
        OutGreenLine "  OK "
        OutLine "$2 is a broken link, as expected. fixing: "
        echo "ln -s $1 $2"
        unlink $2
        ln -s $1 $2
     fi
   elif [ -e $2 ] ; then
     OutRedLine "WTF? "
     OutLine "$2 is not a link."
   else
      OutRedLine "ACHTUNG "
      OutLine "$2 is missing. check yourself."
   fi
   OutLn
}


#makeLink /root/noch /tmp/noch
