#!/bin/bash
INPUT="$(cat)"
echo "$INPUT"
path=`echo "$INPUT" | jq   -r  '.path'`
echo "$path" | 	$RES/addPom.sh  "$1"
echo "$INPUT" | jq   -r  '.insert' | $RES/parseJson.sh "$path" "$1" 
