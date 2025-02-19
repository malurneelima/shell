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
else
    echo "Git is already installed. Nothing to do"
fi