#!/bin/bash

LOGFOLDER="/var/log/shell-expense"
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
        echo -e "$R Please run this script with root privileges $N" |tee -a $LOG_FILE
        exit 1
    fi
}

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is...$R FAILED $N"|tee -a $LOG_FILE
        exit 1
    else
        echo -e "$2 is... $G SUCCESS $N"|tee -a $LOG_FILE
    fi
}
echo "Script started executing at $(date)"|tee -a $LOG_FILE
CHECK_ROOT


dnf module disable nodejs -y
VALIDATE $? "Disabling node jS"
dnf module enable nodejs:20 -y
VALIDATE $? "Enabling node jS"
dnf install nodejs -y
VALIDATE $? "Installing Node js"
