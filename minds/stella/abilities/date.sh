#!/bin/bash

# date.sh - Get Today's Date

d=$(date +%e)

case $d in
    1?) d=${d}th ;;
    *1) d=${d}st ;;
    *2) d=${d}nd ;;
    *3) d=${d}rd ;;
    *)  d=${d}th ;;
esac

echo Today is; date "+%A, %B $d, %Y"