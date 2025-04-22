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

dnf install nginx -y &>>LOG_FILE
VALIDATE $? "Installing nginx"
systemctl enable nginx &>>LOG_FILE
VALIDATE $? "Enabling nginx"
systemctl start nginx
VALIDATE $? "Start nginx"

rm -rf /usr/share/nginx/html/* &>>LOG_FILE # remove default content of nginx
VALIDATE $? "Removing default website"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>LOG_FILE #Download the frontend content
VALIDATE $? "download frontend code"

cd /usr/share/nginx/html &>>LOG_FILE
unzip /tmp/frontend.zip
Validate $? "Extract frontend code"

#cp /home/shell/expense-shell/expense.conf /etc/nginx/default.d/expense.conf

systemctl restart nginx
VALIDATE $? "restart nginx"

