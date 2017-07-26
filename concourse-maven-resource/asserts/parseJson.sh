#!/bin/bash
INPUT="$(cat)"

CREATE_NOTES=" -L "
parse(){
local path=$3
local mstatus=$1
while IFS= read -r key &&
      IFS= read -r value; do
  if [[ "${value:0:1}" == "[" ]]; then
     CREATE_NOTES="$CREATE_NOTES -s ${path} -t elem -n ${key}"
     mstatus=1 
     parse 1 "$value" "${path}/${key}[last()]"
  elif [[ "${value:0:1}" == "{" ]]; then
       if [ "$mstatus" -ne 1 ]; then
         CREATE_NOTES="$CREATE_NOTES -s ${path} -t elem -n ${key}"
         parse 2  "$value" "${path}/${key}[last()]"
       else
         parse 2  "$value" "${path}"
       fi
  else
     CREATE_NOTES="$CREATE_NOTES -s ${path} -t elem -n ${key} -v ${value}"
  fi
done < <(echo  "$2"  | jq  -c -r  '. |keys[] as $k |  ($k, .[$k] | .)')
}

save_line=`grep -P -z -o   -e  "<.*xmlns[^<]*>" $2 | tr -d '\n'`
replace=`echo "$save_line" | head -n1 | cut -d " " -f1`
if [[ ! -z $save_line ]]; then
  sed -i -e ':a' -e 'N' -e '$!ba' -e "s#$replace.*xmlns[^<]*>#$replace vcb=\"wefzug\">#g"  $2
fi

parse 2  "$INPUT" "$1"
xmlstarlet ed $CREATE_NOTES $2


if [[ ! -z $save_line ]]; then
  sed -i -e "s#$replace vcb=\"wefzug\">#$save_line#g"  $2
fi
