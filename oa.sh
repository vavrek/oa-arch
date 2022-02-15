#!/bin/bash

# oa.sh - Open Assistant Launch Script

# Global Settings

export ADDRESS="info@openassistant.org"
export AUDIOPLAYER="aplay"
export BROWSER="librewolf"
export CLICK="xdotool click"
export EDITOR="subl"
export EMAIL="thunderbird"
export FILE="thunar"
export KEY="xdotool key"
export KILL="pkill -f "
export LAUNCH="python3 ./oa.py -c -m 0"
export MINDDIR="$PWD/minds/stella"
export OADDIR="$PWD"
export SEARCHFILES="catfish"
export SEARCHWEB="https://duckduckgo.com"
export STATUS="bpytop"
export TYPE="xdotool type"
export USERNAME=$(whoami)
export VOICE="flite -voice slt --setf int_f0_target_mean=263 --setf duration_stretch=1.22 --setf int_f0_target_stddev=27"
export TERMINAL="xfce4-terminal --maximize"

# Launch Open Assistant

python3 ./oa.py -c -m 0
