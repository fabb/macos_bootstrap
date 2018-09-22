#!/bin/bash

SLEEP_TIME=`sysctl -a |grep sleeptime` # e.g. kern.sleeptime: { sec = 1421576213, usec = 39481 } Sun Jan 18 11:16:53 2015
WAKE_TIME=`sysctl -a |grep waketime`

REGEX_SEC_SLEEP_TIME="kern.sleeptime: { sec = ([0-9]+), usec(.*)"
REGEX_SEC_WAKE_TIME="kern.waketime: { sec = ([0-9]+), usec(.*)"

REGEX_DATE_TIME="(.*) } (.*)"

if [[ $SLEEP_TIME =~ $REGEX_SEC_SLEEP_TIME ]]; then
	SLEEP_TIME_SECS=${BASH_REMATCH[1]}; 
fi

if [[ $WAKE_TIME =~ $REGEX_SEC_WAKE_TIME ]]; then
	WAKE_TIME_SECS=${BASH_REMATCH[1]}; 
fi

if [[ $SLEEP_TIME =~ $REGEX_DATE_TIME ]]; then
	SLEEP_DATE_TIME=${BASH_REMATCH[2]}; 
fi

if [[ $WAKE_TIME =~ $REGEX_DATE_TIME ]]; then
	WAKE_DATE_TIME=${BASH_REMATCH[2]}; 
fi

let SECS=$WAKE_TIME_SECS-$SLEEP_TIME_SECS
let HOURS=$SECS/3600
let MINUTES=($SECS/60)%60

echo ""
echo "-------------------------------------------------"
echo "  Sleep Time: $SLEEP_DATE_TIME"
echo "   Wake Time: $WAKE_DATE_TIME"
echo "							"
echo "  You were gone for $HOURS hour(s) and $MINUTES minute(s)."
echo "-------------------------------------------------"
echo ""

