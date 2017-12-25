
source ./calc_env.sh

>$final_dst

while read line || [ -n "$line" ]
do

  #awk -F "\"*,\"*" '{print $3}' $final_src 
  name=`echo $line | awk -F "\"*,\"*" '{print $2}' | tr A-Z a-z`
  if [[ ${name,,} != "username" ]]
  then
    mark=`echo $line | awk  -F "\"*,\"*" '{print $3}' | awk '{ print $1 }' | cut -f1 -d"."`
    echo "$name $mark" >> $final_dst
  fi
done < $final_src
sort $final_dst -o $final_dst
