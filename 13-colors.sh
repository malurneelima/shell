#!/bin/bash

USERID=$(id -u)
echo "User id is : $USERID"

R="\e[31m"
G="\e[32m"
N="\e[0m"

VALIDATE(){
    echo "The exit status is $1" #Here as validate function is sending the input details in the form of arguments, we are retriving using $1.
    if [ $1 -ne 0 ]
    then 
        echo -e "$2 is ....$R FAILED $N"
        exit 1;
    else
        echo -e "$2 is ....$G SUCCESS $N"
    fi
}

if [ $USERID -ne 0 ]
then
    echo "Please run this script with root privilages"
    exit 1
fi

dnf list installed git



if [ $? -ne 0 ]
then
    echo "Git is not installed. Going to install now..."
    dnf install git -y
    VALIDATE $? "Installing Git"

else
    echo "Git is already installed. Nothing to do"
fi

dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "Mysql is not installed...Going to install"
    dnf install mysql -y
    VALIDATE $? "Installing MySql"
else
    echo "Mysql is already installed.. Nothing to do"
fi
