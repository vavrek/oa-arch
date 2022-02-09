#!/bin/bash

# mic-test.sh - Microphone test

set -e

function complete {
  rm mic-test.wav
}

trap complete EXIT

printf "\nLaunching recording test...\n\nRecognized input devices: \n\n"

arecord -l

printf "\nRecording for 5 seconds.\n\nPlease speak into your microphone...\n\n"

arecord -f S16_LE -c 2 -r 192000 -d 5 mic-test.wav

printf "\nComplete. Playing recording...\n\n"

aplay -D hw:0,0 mic-test.wav

printf "\nIf you do not hear anything, please check your microphone input levels and speaker volume.\n\n"

