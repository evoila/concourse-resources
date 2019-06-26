#!/bin/bash
INPUT="$(cat)"
XML_INPUT=
XmlCreateElments()
{
   xmlstarlet sel  -T -t -v "$1" "$2" > /dev/null
   if [ "$?" -ne 0  ]; then
     local XML_PATH=`dirname $1`
     if [ "$XML_PATH" != "/" ]; then
       XmlCreateElments $XML_PATH $2
     fi
     ELEMENT=`basename $1`
     xmlstarlet ed  -L -s $XML_PATH -t elem -n $ELEMENT -v "" $2
   fi
}


save_line=`grep -P -z -o   -e  "<.*xmlns[^<]*>" $1 | tr -d '\n'`
replace=`echo "$save_line" | head -n1 | cut -d " " -f1`
if [[ ! -z $save_line ]]; then
  sed -i -e ':a' -e 'N' -e '$!ba' -e "s#$replace.*xmlns[^<]*>#$replace vcb=\"wefzug\">#g"  $1
fi

XmlCreateElments $INPUT $1

if [[ ! -z $save_line ]]; then
  sed -i -e "s#$replace vcb=\"wefzug\">#$save_line#g"  $1
fi
