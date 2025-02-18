#!/bin/bash
echo "I want all the variables to be passed to script $@"
echo "Number of variables passed to the script $#"
echo "Script name is $0"
echo "Current working directory $PWD"
echo "Home directory of current user $HOME"
echo "Process instance id of currentky executing script $$"
sleep 100 &
echo "Process instance if of last background command $!"