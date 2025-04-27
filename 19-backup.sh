#!/bin/bash
SOURCE_DIR=$1
DEST_DIR=$2;
DAYS=${3:-14} #if $3 is empty, default is 14 days
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"  
USAGE(){
    echo -e "$R USAGE: $N sh 19-backup.sh <source> <destination> <number of days>(optional)"
}
#check if source and destination are empty
if [ $# -lt 2 ]
then
    USAGE
fi
#checking if the dir exits or no -d is test if it is a dir
if [ -d $SOURCE_DIR ]
then
    echo "$SOURCE_DIR does not exist....Please check"
fi

if [ -d $DEST_DIR ]
then 
    echo "$DEST_DIR does not exist...Please check"
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)
echo "Files: $Files"
if [ ! -z $FILES ] # true if file is empty, ! makes the expr false
then
    echo "Files are found"
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"  #app-logs-<timestamp>.zip
    find $SOURCE_DIR -name "*.log" -mtime +14 | zip "$ZIP_FILE" -@

    #check if zip file successfully created or not
    if [ -f $ZIP_FILE ]
    then
        echo "Successfully zipped files older than $DAYS"
        while IFS= read -r file #IFS means internal field separator,empty it will ignore white spaces. -r  is for not to ignore special chars like /.
        do 
            echo "Deleting file : $file"
            rm -rf $file
        done <<< $FILES
    else
        echo "Zipping the files failed"
        exit 1
        
    fi
    #after zipping , remove from source dir
    
else
    echo "No files older than $DAYS"
fi

