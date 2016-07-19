#count=`svn list http://172.18.1.5/svn/wimax/mt7119/branches/ | wc -l`

svn list http://172.18.1.5/svn/wimax/mt7119/branches/ > /tmp/svnlist
count=`cat /tmp/svnlist | wc -l`

filename=/tmp/svnlist
index=1
while read line; do
svnlist[$index]="$line"
index=`expr $index + 1`
done < $filename

start=1
end=`expr $count - 0`
#read -p "Please choose the number you want to checkout now:" userinputnumber #將不會顯示下列選單
echo "Please choose the number you want to checkout now:"
for i in $(seq $start $end)
do
number=`expr $i + 0`
echo $number. ${svnlist[i]}
done

read userinputnumber
month=`date +%m`
day=`date +%d`

branchespath="http://172.18.1.5/svn/wimax/mt7119/branches/"${svnlist[$userinputnumber]}
echo $branchespath
foldername=`echo ${svnlist[$userinputnumber]} | sed "s/\///g"`
echo $foldername
svn checkout $branchespath $foldername-$month$day
#echo $userinputnumber $month$day
