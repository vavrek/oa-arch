#!/bin/bash

# yes.sh - Affirmative Response Script

TOPIC=$(echo $(cat $MINDDIR/abilities/topic))

case $TOPIC in
"none")
  echo "ok..." | $VOICE
  ;;
"diagnostics")
  $MINDDIR/abilities/diagnostics.sh
  ;;
"jokes")
 shuf -n 1 $MINDDIR/abilities/jokes | tee /dev/tty | $VOICE
  ;;
esac
