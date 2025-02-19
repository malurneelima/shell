#!/bin/bash

USERID=$(id -u)
echo "User id is : $USERID"

VALIDATE(){
    echo "The exit status is $1" #Here as validate function is sending the input details in the form of arguments, we are retriving using $1.
}

if [ $USERID -ne 0 ]
then
    echo "Please run this script with root privilages"
    exit 1
fi

dnf list installed git

VALIDATE $? # here making a calling to function and passing inputs as arguments

# if [ $? -ne 0 ]
# then
#     echo "Git is not installed. Going to install now..."
#     dnf install git -y
#     if [ $? -ne 0 ]
#     then 
#         echo "Git installation is not successful..Check it"
#         exit 1;
#     else
#         echo "Git insatllation is successful"
#     fi
# else
#     echo "Git is already installed. Nothing to do"
# fi

# dnf list installed mysql

# if [ $? -ne 0 ]
# then
#     echo "Mysql is not installed...Going to install"
#     dnf install mysql -y
#     if [ $? -ne 0 ]
#     then
#         echo "mysql is not installed properly..Please check"
#         exit 1
#     else
#         echo "My SQL is successfully installed"
#     fi
# else
#     echo "Mysql is already installed.. Nothing to do"
# fi
