
m0=final.csv

m0txt="grades_final"

>$m0txt.txt

while read line || [ -n "$line" ]
do

  #awk -F "\"*,\"*" '{print $3}' $m0 
  name=`echo $line | awk -F "\"*,\"*" '{print $2}' | tr A-Z a-z`
  if [[ ${name,,} != "username" ]]
  then
    mark=`echo $line | awk  -F "\"*,\"*" '{print $3}' | awk '{ print $1 }' | cut -f1 -d"."`
    echo "$name $mark" >> $m0txt.txt
  fi
done < $m0
sort $m0txt.txt -o $m0txt.txt
