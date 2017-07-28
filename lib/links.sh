### IMPORT
source ./out.sh
#########

function getLinkDestination
{
 result=`ls -l $1 | sed -e 's/.* -> //'`
 echo $result
}

# expects full paths:
# first param is where to link
# second param is a broken link to fix   



function fixLink
{
   if [ -L $2 ] ; then
     if [ -e $2 ] ; then
        OutRedLine "ACHTUNG "
        OutLine "$2 is a good link, checking link destination"
        OutLn
        tmp=`getLinkDestination "$2"`
        if [ "$tmp" == "$1" ] ; then
            OutGreenLine "  OK "
            OutLine "link $2 points to the right destination" 
            OutLn
        else
            OutRedLine   "  ACHTUNG indeed "
            OutLine      "link points to the wrong destination"
            OutLn
            OutLine      "please check yourself"
            OutLn
        fi 
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
      OutLine "$2 is missing, so unable to fix it."
      OutLn
      OutGreenLine "Creating "
      OutLine "ln -s $1 $2"
      OutLn
      ln -s $1 $2
   fi
   OutLn
}


fixLink /tmp/noch /tmp/bbb
#a=`getLinkDestination "/tmp/noch"`
#echo $a
