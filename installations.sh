#!/bin/bash

USERID=$(id -u)
echo "User id is : $USERID"
if [ $USERID -ne 0 ]
then
    echo "Please run this script with root privilages"
    exit 1
fi

dnf install git -y