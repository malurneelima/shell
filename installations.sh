#!/bin/bash

USERID=$(id -u)
echo "User id is : $USERID"
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
    if [ $? -ne 0 ]
    then 
        echo "Git installation is not successful..Check it"
        exit 1;
    else
        echo "Git insatllation is successful"
    fi
else
    echo "Git is already installed. Nothing to do"
fi