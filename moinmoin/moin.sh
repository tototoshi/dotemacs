#!/bin/bash
moinrc=$HOME/.moinrc
if [ ! -f $moinrc ]; then
    echo "~/.moinrc not found."
fi

which curl > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "curl not found."
    exit 1
fi

curl -u $(cat $moinrc) $1 2> /dev/null |\
$(dirname "$0")/moin_parser
