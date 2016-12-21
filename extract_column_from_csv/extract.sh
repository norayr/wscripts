# csv file name
CSV=textfile.csv
# fifth column in text file
RES0=tmp.txt
# lowercase result
RES1=lowercase.txt
# this will extract fifth column from the csv file
awk -F "\"*,\"*" '{print $5}' $CSV > $RES0
# and make the result lowercase
tr A-Z a-z < $RES0 > $RES1
