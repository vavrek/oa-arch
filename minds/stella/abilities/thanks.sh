#!/bin/bash

# thanks.sh - Appreciation Shuffle Script

thanks=$MINDDIR/abilities/thanks
name=$MINDDIR/abilities/username

shuf -n1 > $thanks <<EOFthanks
thanks
thanks so much
thank you too
much appreciated
my pleasure
no problem
EOFthanks

shuf -n1 > $name <<EOFname
$USERNAME
EOFname

response=$(echo "$(cat $thanks) $(cat $name)")

echo $response | $VOICE
