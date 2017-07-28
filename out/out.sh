RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

function OutRedLine
{
paramslist=""
  for i in $@
  do
     paramslist="${paramslist} ${i}"
  done
printf " ${RED}${paramslist}${NC}"
}

function OutGreenLine
{
paramslist=""
  for i in $@
  do
     paramslist="${paramslist} ${i}"
  done
printf " ${GREEN}${paramslist}${NC}"
}


function OutLn
{
 printf "\n"

}


OutRedLine "aaa aaa aaa"
OutGreenLine "aaa aaa aaa"
OutLn
