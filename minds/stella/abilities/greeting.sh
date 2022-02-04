#!/bin/bash

# greeting.sh - Generate A Random Greeting

greeting=$MINDDIR/abilities/greeting
name=$MINDDIR/abilities/username

shuf -n1 > $greeting <<EOFgreeting
hello
hey
hi 
hi there
howdy
yes
EOFgreeting

shuf -n1 > $name <<EOFname
$USERNAME
EOFname

response=$(echo "$(cat $greeting) $(cat $name)")

echo $response | $VOICE
