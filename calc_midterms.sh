
m0=midterm0.csv
m1=midterm1.csv
m2=midterm2.csv

m0txt="grades_midterm0"
m1txt="grades_midterm1"
m2txt="grades_midterm2"

gradesout="grades_midterms_all.txt"
gradesfinal="grades_midterms_final.txt"

>$m0txt.txt
>$m1txt.txt
>$m2txt.txt
>$gradesout
>$gradesfinal

while read line
do

  #awk -F "\"*,\"*" '{print $3}' $m0 
  name=`echo $line | awk -F "\"*,\"*" '{print $2}' | tr A-Z a-z`
  if [[ ${name,,} != "username" ]]
  then
    mark=`echo $line | awk  -F "\"*,\"*" '{print $3}' | awk '{ print $1 }' | tr A-Z a-z`
    echo "$name $mark" >> $m0txt.txt
  fi
done < $m0


while read line
do

  name=`echo $line | awk -F "\"*,\"*" '{print $2}' | tr A-Z a-z`
  if [[ ${name,,} != "username" ]]
  then
    mark=`echo $line | awk  -F "\"*,\"*" '{print $3}' | awk '{ print $1 }'`
    echo "$name $mark" >> $m1txt.txt
  fi
done < $m1

while read line
do

  name=`echo $line | awk -F "\"*,\"*" '{print $2}' | tr A-Z a-z`
  if [[ ${name,,} != "username" ]]
  then
    mark=`echo $line | awk  -F "\"*,\"*" '{print $3}' | awk '{ print $1 }'`
    echo "$name $mark" >> $m2txt.txt
  fi
done < $m2

sort $m0txt.txt > ${m0txt}_sorted.txt
sort $m1txt.txt > ${m1txt}_sorted.txt
sort $m2txt.txt > ${m2txt}_sorted.txt

#now calculate by using the participation of the first as reference
#first dirty fix, for some reason there is rouben_khachatryan at first midterm, then ruben_khachatryan
sed -i 's/rouben_khachatryan/ruben_khachatryan/' ${m0txt}_sorted.txt


while read line
do
  nm=`echo $line | awk '{print $1}' | tr A-Z a-z`
  gr0=`echo $line | awk '{print $2}' | cut -f1 -d"."`
  gr1=`cat ${m1txt}_sorted.txt | grep $nm | awk '{print $2}' | cut -f1 -d"."`
  if [[ "$nm" == "arshak_minasyan@edu.aua.am" ]]
  then
    gr1="75" #passed exam later with 95, substracted 20 from the result.
  fi
  gr2=`cat ${m2txt}_sorted.txt | grep $nm | awk '{print $2}' | cut -f1 -d"."`
  sum=$(( $gr0 + $gr1 + $gr2 ))
  res=`echo "scale=2; $sum / 3" | bc`
  res_rounded=`printf '%.*f\n' 0 $res`
  echo "$nm $gr0 $gr1 $gr2 $res_rounded" >> $gradesout
  echo "$nm $res_rounded" >> $gradesfinal
done < ${m0txt}_sorted.txt



