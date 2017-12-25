source ./calc_env.sh

>$m0_dst.txt
>$m1_dst.txt
>$m2_dst.txt
>$midterms_tmp
>$midterms_dst

while read line || [ -n "$line" ]
do

  #awk -F "\"*,\"*" '{print $3}' $m0_src 
  name=`echo $line | awk -F "\"*,\"*" '{print $2}' | tr A-Z a-z`
  if [[ ${name,,} != "username" ]]
  then
    mark=`echo $line | awk  -F "\"*,\"*" '{print $3}' | awk '{ print $1 }' | tr A-Z a-z`
    echo "$name $mark" >> $m0_dst.txt
  fi
done < $m0_src

while read line || [ -n "$line" ]
do

  name=`echo $line | awk -F "\"*,\"*" '{print $2}' | tr A-Z a-z`
  if [[ ${name,,} != "username" ]]
  then
    mark=`echo $line | awk  -F "\"*,\"*" '{print $3}' | awk '{ print $1 }'`
    echo "$name $mark" >> $m1_dst.txt
  fi
done < $m1_src

while read line || [ -n "$line" ]
do

  name=`echo $line | awk -F "\"*,\"*" '{print $2}' | tr A-Z a-z`
  if [[ ${name,,} != "username" ]]
  then
    mark=`echo $line | awk  -F "\"*,\"*" '{print $3}' | awk '{ print $1 }'`
    echo "$name $mark" >> $m2_dst.txt
  fi
done < $m2_src

sort $m0_dst.txt > ${m0_dst}_sorted.txt
sort $m1_dst.txt > ${m1_dst}_sorted.txt
sort $m2_dst.txt > ${m2_dst}_sorted.txt

#now calculate by using the participation of the first as reference
#first dirty fix, for some reason there is rouben_khachatryan at first midterm, then ruben_khachatryan
sed -i 's/rouben_khachatryan/ruben_khachatryan/' ${m0_dst}_sorted.txt


while read line || [ -n "$line" ]
do
  nm=`echo $line | awk '{print $1}' | tr A-Z a-z`
  gr0=`echo $line | awk '{print $2}' | cut -f1 -d"."`
  gr1=`cat ${m1_dst}_sorted.txt | grep $nm | awk '{print $2}' | cut -f1 -d"."`
  if [[ "$nm" == "arshak_minasyan@edu.aua.am" ]]
  then
    gr1="75" #passed exam later with 95, substracted 20 from the result.
  fi
  if [[ "$nm" == "davit_abovyan@edu.aua.am" ]]
  then
    gr1="65" #passed exam later with 85, substracted 20 from the result.
  fi

  gr2=`cat ${m2_dst}_sorted.txt | grep $nm | awk '{print $2}' | cut -f1 -d"."`
  sum=$(( $gr0 + $gr1 + $gr2 ))
  res=`echo "scale=2; $sum / 3" | bc`
  res_rounded=`printf '%.*f\n' 0 $res`
  echo "$nm $gr0 $gr1 $gr2 $res_rounded" >> $midterms_tmp
  echo "$nm $res_rounded" >> $midterms_dst
done < ${m0_dst}_sorted.txt

  #virab did not participate any midterm, still need to generate smth
  echo "virab_gevorgyan@edu.aua.am    59" >> $midterms_dst

