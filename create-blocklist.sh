#!/bin/bash

curl https://www.iblocklist.com/lists.php  | grep -Po "http:\/\/list.iblocklist.com/\?list=[^']*" > file_list
wget -c -i file_list

j=1
for i in *archiveformat=gz; do mv $i $j.txt.gz; j=$(($j+1)); done

gunzip *.gz

cat *.txt | uniq > blocklist

LINES=`cat blocklist | wc -l`
echo -e "\nBlocklist created: $LINES lines\n"

ls -lh blocklist
rm *.txt

exit 0
