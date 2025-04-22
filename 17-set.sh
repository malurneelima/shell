#!/bin/bash

set -ex # setting the automatic exit if we get error.-e-->Exit immediately if any command returns a non-zero (error) status.and -x -->Print each command, USeful for debugging.
failure(){
    echo "Failed at $1:$2"
}

trap 'failure "${LINENO}" "$BASH_COMMAND"' ERR #ERR is the error signal. if we get any error then trap command will catch it.

echo "Hello World"
echooo "Hello World failure"
echo "Hello world after failure"

