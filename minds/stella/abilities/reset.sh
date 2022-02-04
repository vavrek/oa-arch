#!/bin/bash

# reset.sh - Open Assistant Reset Script

kill -9 `ps -A | awk ' ($4=="oa.py") {print $1}'`

$OADIR/oa.sh