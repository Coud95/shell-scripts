#!/bin/bash
 cat << "EOF"
   ____     __   ____                 __
  / __/_ __/ /  / __/__  _______  ___/ /__ ____
 _\ \/ // / _ \/ _// _ \/ __/ _ \/ _  / -_) __/
/___/\_,_/_.__/___/_//_/\__/\___/\_,_/\__/_/    Version 1.0
EOF
# Author: Przemysław Nikiel

encode ()
{
    echo "$1"
    value=$(<"$1")
    echo "$value" | iconv --from-code=WINDOWS-1250 --to-code=utf-8 --output="$1"
}

echo "Encoded files:"
if [ $# -eq 0 ]
then
    OIFS="$IFS"
    IFS=$'\n'
    for file in `find . -type f \( -iname \*.txt -o -iname \*.srt -o -iname \*.ass -o -iname \*.sub \)`
    do
        encode "$file"
    done
    IFS="$OIFS"
fi

for SUBTITLE_FILE in "$@"
do
    
    if [ ! -f "$SUBTITLE_FILE" ]; then
        echo "$SUBTITLE_FILE not found!"
        break
    fi
    
    encode "$SUBTITLE_FILE"
done