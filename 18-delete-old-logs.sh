#!/bin/bash
 
SOURCE_DIR="/home/ec2-user/logs"
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"


if [ -d $SOURCE_DIR ]
then
    echo -e "$SOURCE_DIR $G Exists $N"
else
    echo -e "$SOURCE_DIR $R does not exist $N"
    exit 1
fi
FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)
echo "Files : $FILES"

#don't use line, it is reserved word.
while IFS= read -r file #IFS means internal field separator,empty it will ignore white spaces. -r  is for not to ignore special chars like /.
do 
    echo "Deleting file : $file"
    rm -rf $file
done <<< $FILES