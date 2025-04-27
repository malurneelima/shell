#!/bin/bash
SOURCE_DIR=$1
DEST_DIR=$2;
DAYS=${3:-14} #if $3 is empty, default is 14 days

R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"  
USAGE(){
    echo -e "USAGE: $R sh 19-backup.sh $N <source> <destination> <number of days>(optional)"
}
#check if source and destination are empty
if [ $# -lt 2 ]
then
    USAGE
fi