#!/bin/bash

which curl >/dev/null 2>&1
if [ $? -eq 1 ]
then
	echo "Installing curl package..."
	sudo apt-get install curl
fi
which curl >/dev/null 2>&1
if [ $? -eq 1 ]
then
	echo "curl is not installed!"
	exit 1
fi

which wget >/dev/null 2>&1
if [ $? -eq 1 ]
then
	echo "Installing wget package..."
	sudo apt-get install wget
fi
which wget >/dev/null 2>&1
if [ $? -eq 1 ]
then
	echo "wget is not installed!"
	exit 1
fi

curl https://www.iblocklist.com/lists.php  | grep -Po "http:\/\/list.iblocklist.com/\?list=[^']*" > file_list
wget -c -i file_list
j=1;for i in *archiveformat=gz; do mv $i $j.txt.gz; j=$(($j+1)); done
gunzip *.gz
cat *.txt | uniq > blocklist
rm *.txt

LINES=`cat blocklist | wc -l`
echo -e "\nBlocklist created: $LINES lines\n"
ls -lh blocklist

exit 0
