rec(){
echo "---$1"
local save_line=`grep -P -z -o   -e  "<.*xmlns[^<]*>" $1 | tr -d '\n'`
local replace=`echo "$save_line" | head -n1 | cut -d " " -f1`
local path=$1
if [[ ! -z $save_line ]]; then
  sed -i -e ':a' -e 'N' -e '$!ba' -e "s#$replace.*xmlns[^<]*>#$replace vcb=\"wefzug\">#g"  $1
fi

parent=`xmlstarlet sel -T -t -v /project/parent/groupId -o '.' -v  /project/parent/artifactId  < "$1"`
mversion=`xmlstarlet sel -T -t -i  /project/groupId -v /project/groupId  --else  -v /project/parent/groupId -b -o '.' -v  /project/artifactId <  "$1"`
for var in "$@"
do
    if [ "${var:0:2}" == "-D" ]; then
      arg="${var:2}"
      sed -i -e "s#\${${arg%=*}}#${arg##*=}#g" "$1"
      [ "${arg%=*}" == "$mversion" ] &&  xmlstarlet ed -L -u  /project/version -v "${arg##*=}"  "$1"
      [ "${arg%=*}" == "$parent" ] &&  xmlstarlet ed -L -u  /project/parent/version -v "${arg##*=}"  "$1"
    fi
done

cat $path

while IFS= read -r value; do
  rec `dirname "$path"`"/$value/pom.xml" "$@"
done< <(xmlstarlet sel -t -v  /project/modules/module  $1 && echo "")

if [[ ! -z $save_line ]]; then
  sed -i -e "s#$replace vcb=\"wefzug\">#$save_line#g"  $1
fi

}

PATHS="pom.xml"

while getopts ":f:" o; do
    case "${o}" in
        f)
            PATHS=${OPTARG}
            break
            ;;
        *)
            ;;
    esac
done

rec "$PATHS" "$@"

echo "$@"

mvn "$@"
