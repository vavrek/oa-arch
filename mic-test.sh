#!/bin/bash

# mic-test.sh - Open Assistant microphone test

set -e

function complete {
  rm mic-test.wav
}

trap finish EXIT

printf ">>Launching ALSA recording test.\n >> Recognized input devices: \n"

arecord -l

printf "\n>>Recording for 5 seconds. Please speak into your microphone...\n"

arecord -f S16_LE -c 2 -r 192000 -d 5 mic-test.wav

printf "\n>>Playing recording...\n"

aplay -D hw:0,0 test_audio.wav

printf "\n>>If nothing was heard, please check your microphone input settings and speaker levels.\n"

