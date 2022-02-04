#!/bin/bash

# good.sh - Positive Remark Shuffle Script

good=./good

shuf -n1 > $good <<EOFgood
awesome
cool
excellent
fantastic
good
great
lovely
nice
wonderful
EOFgood

echo "$(cat $good)" | $VOICE
