#!/bin/bash
if [ "$#" -lt 1 ]; then
        echo "Usage is $0 <burp_file> <outfile>(optional)"
        echo "Default out file is wordlist.txt"
        exit
elif [ "$#" -eq 1 ]; then
        cat $1| egrep -iHona "(GET|POST|PUT|HEAD|DELETE|OPTIONS)\ [a-z0-9\?\'\&\=\"\ \/\\]+? HTTP\/[0-9\.]*" | cut -d " " -f3 | sort -u >wordlist.txt
else
        cat $1| egrep -iHona "(GET|POST|PUT|HEAD|DELETE|OPTIONS)\ [a-z0-9\?\'\&\=\"\ \/\\]+? HTTP\/[0-9\.]*" | cut -d " " -f3 | sort -u >"$2"
fi
