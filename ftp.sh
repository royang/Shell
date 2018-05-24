#! /bin/bash

LOCAL_DIR="/home/pi/Documents"


while :
do

cnt_file=`ls $LOCAL_DIR/images/ | wc -l`

if [ $cnt_file -gt 0 ]
then 
files=()
for file in $LOCAL_DIR/images/*
do
	files+=(`echo $file | awk -F "/" '{print $NF}'`)
	echo "add to array:$file"
done

echo "************************************************"
echo "************* size: ${#files[@]}****************"
echo "************************************************"


ftp -v -n 192.168.31.33<<!
user zdh roy
echo "user login"
binary
cd /ftp
lcd $LOCAL_DIR/images/
echo "cd documents"

prompt
mput ${files[@]}
	
echo "close" 
close
bye
echo "disconnect"
!

for file in ${files[@]}
do
	mv $LOCAL_DIR/images/$file $LOCAL_DIR/backup/$file
	echo "move $file"
done

unset files
else
echo "no files upload..."
sleep 10

fi

done
