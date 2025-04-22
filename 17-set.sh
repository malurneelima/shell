#!/bin/bash

set -ex # setting the automatic exit if we get error.-e-->Exit immediately if any command returns a non-zero (error) status.and -x -->Print each command, USeful for debugging.
echo "Hello World"
echooo "Hello World failure"
echo "Hello world after failure"

