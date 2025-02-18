#!/bin/bash
echo "Please enter your username"
read  USERNAME #takes input into username variable. to hide what ever we are typing in theterminal, we can use -s.
echo "The username you entered is $USERNAME"
echo "Pleas enter your password"
read -s PASSWORD
echo "The password you entered is ${PASSWORD}"