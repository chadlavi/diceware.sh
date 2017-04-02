#!/bin/sh
(
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
count=0
results=()
read -n 1 -s -p "To use diceware, roll a d6 five times for each word."
echo ""
read -n 1 -s -p "WHEN YOU HAVE YOUR DI(C)E READY, PRESS ANY KEY"
echo "\n\n"
read -p "How many words do you need? (default: 6) "  words
words=${words:-6}
re='^[0-9]+$'
reg='^[1-6]{5}$'
while ! [[ $words =~ $re ]] ; do
	read -p "Number of words must be integer: " words
done
while [ $count -lt $words ]; do
count=$(($count + 1))
read -p "List your 5 rolls for word $count as a single string (e.g., '12345'): " key
while ! [[ $key =~ $reg ]] ; do
	read -p "Rolls for word $count must be entered as 5 digits between 1 and 6: " key
done
results+=$(cat $DIR/dictionary.txt | grep $key | awk '{print $2}')
results+=" "
done
echo "\n\nResult:\n\n${results}\n"
)
