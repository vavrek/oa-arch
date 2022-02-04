#!/bin/bash

# oa.sh - Open Assistant Launch Script

# Global Settings

export ADDRESS="your@address.com"
export AUDIOPLAYER="aplay"
export BROWSER="firefox"
export CLICK="xdotool click"
export EDITOR="vim"
export EMAIL="thunderbird"
export FILE="thunar"
export KEY="xdotool key"
export KILL="pkill -o -f "
export LAUNCH="python3 ./oa.py -c -m 0"
export MASTERPASS="password"
export MINDDIR="$PWD/minds/stella"
export OADDIR="$PWD"
export PASSWORD="password"
export SEARCHFILES="catfish"
export SEARCHWEB="https://duckduckgo.com"
export STATUS="bpytop"
export TYPE="xdotool type"
export USERNAME=$(whoami)
export VOICE="flite -voice slt --setf int_f0_target_mean=263 --setf duration_stretch=1.11 --setf int_f0_target_stddev=27"
export TERMINAL="xfce4-terminal --maximize"

# Launch Open Assistant

python3 ./oa.py -c -m 0
