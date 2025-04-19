#!/bin/bash

LOGFOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 |cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGFOLDER/$SCRIPT_NAME-$TIMESTAMP.log"
mkdir -p $LOGFOLDER
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then
        echo -e "$R Please run this script with root privileges $N" &>>$LOG_FILE
        exit 1
    fi
}

USAGE(){
    echo -e "$R USAGE:: $N sudo sh $0 package1 package2 ...."
    exit 1
}

if [ $# -eq 0 ]
then
    USAGE
fi

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is...$R FAILED $N"
        exit 1
    else
        echo -e "$2 is... $G SUCCESS $N"
    fi
}

CHECK_ROOT
# We can execute as sh 14-loops.sh git httpd ..
for package in $@
do
    dnf list installed $package &>>$LOG_FILE
    if [ $? -ne 0 ]
    then
        echo "$package is not installed...going to install"&>>$LOG_FILE
        dnf install $package -y
        VALIDATE $? "Installing $package"
    else
        echo -e "$package is already $Y installed..nothing to do $N"&>>$LOG_FILE
    fi
done


