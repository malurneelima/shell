#!/bin/bash

USERID=$(id -u)
echo "User id is : $USERID"

VALIDATE(){
    echo "The exit status is $1" #Here as validate function is sending the input details in the form of arguments, we are retriving using $1.
    if [ $1 -ne 0 ]
    then 
        echo "$2 is ....FAILED"
        exit 1;
    else
        echo "$2 is ....SUCCESS"
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
