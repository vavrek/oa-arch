#!/bin/bash

# mic-test.sh - Open Assistant microphone test

set -e

function complete {
  rm mic-test.wav
}

trap finish EXIT

printf "Launching ALSA recording test.\n Recognized input devices: \n"

arecord -l

printf "\nRecording for 5 seconds. Please speak into your microphone...\n"

arecord -f S16_LE -c 2 -r 192000 -d 5 mic-test.wav

printf "\nPlaying recording...\n"

aplay -D hw:0,0 mic-test.wav

printf "\nIf you didn't hear anything, please check your microphone input settings and speaker levels.\n"

