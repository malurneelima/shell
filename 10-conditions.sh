#!/bin/bash
NUMBER=$1

if [ $NUMBER -gt 20 ]
then
    echo "Given number: $NUMBER greater than 20"
else
    echo "Given number: $NUMBER less than 20"
fi