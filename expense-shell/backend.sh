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


dnf module disable nodejs -y &>>LOG_FILE
VALIDATE $? "Disable default nodejS"
dnf module enable nodejs:20 -y &>>LOG_FILE
VALIDATE $? "Enable nodejS:20"
dnf install nodejs -y &>>LOG_FILE
VALIDATE $? "Install nodejs"
id expense &>>LOG_FILE
if [ $? -ne 0 ]
then
    echo -e "Expense user does not exist. $G Creating $N"
    useradd expense &>>LOG_FILE
    VALIDATE $? "Creating expense user"
else
    echo -e "Expense user is already exists...$Y SKIPPING $N"
    
fi

mkdir -p /app
VALIDATE $? " Creating /app folder"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>> LOG_FILE
VALIDATE $? "Downloading Backend application code"

cd /app
unzip /tmp/backend.zip &>>LOG_FILE
VALIDATE $? "Extracting backend application code"

#cd /app
#npm install
#vim /etc/systemd/system/backend.service
