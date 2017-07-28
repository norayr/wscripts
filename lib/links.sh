### IMPORT
source ./out.sh
#########

# accepts src and dst like ln does
# expects:
# first param is where to link
# second param is a broken link to fix   

function makeLink
{

   if [ -L $2 ] ; then
     if [ -e $2 ] ; then
        OutRedLine "ACHTUNG "
        OutLine "${tmplnk} is good link, did you remove the link destination?"
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
