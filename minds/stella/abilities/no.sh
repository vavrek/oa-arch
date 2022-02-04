#!/bin/bash

# no.sh - Negative Remark Script

TOPIC=$(echo $(cat $MINDDIR/words/topic))

if [ $TOPIC = "diagnostics" ]; then
	echo "ok... no diagnostics..." | $VOICE
else
	echo "ok..." | $VOICE
fi
