#!/bin/bash
if [ "$#" -lt 1 ]; then
        echo "Usage is $0 <burp_file> <outfile>(optional)"
        echo "Default out file is wordlist.txt"
        exit
elif [ "$#" -eq 1 ]; then
        echo "Fetching requests in the state file"
        cat $1| egrep -iHona "(GET|POST|PUT|HEAD|DELETE|OPTIONS)\ [a-z0-9\?\'\&\=\"\ \/\\]+? HTTP\/[0-9\.]*" | cut -d " " -f3 | sort -u >tmp.txt
        echo "Fetching urls in the src and href attributes"
        cat $1| egrep -iHona "(href|src)=(\"|\')[a-z0-9\?\&\=\ \/\\\:\_\-]+?*(\"|\')" | cut -d "=" -f2 | sed "s:\"::g" | sed "s:\'::g" | sort -u >>tmp.txt
        cat tmp.txt | sort -u > wordlist.txt
        rm tmp.txt
else
        echo "Fetching requests in the state file"
        cat $1| egrep -iHona "(GET|POST|PUT|HEAD|DELETE|OPTIONS)\ [a-z0-9\?\'\&\=\"\ \/\\]+? HTTP\/[0-9\.]*" | cut -d " " -f3 | sort -u >tmp.txt
        echo "Fetching urls in the src and href attributes"
        cat $1| egrep -iHona "(href|src)=(\"|\')[a-z0-9\?\&\=\ \/\\\:\_\-]+?*(\"|\')" | cut -d "=" -f2 | sed "s:\"::g" | sed "s:\'::g" | sort -u >>tmp.txt
        cat tmp.txt | sort -u >"$2"
        rm tmp.txt
fi
