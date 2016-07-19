month=`date +%m`
echo "month is " $month
#使用expr來做四則運算 減號的前後需要有空格
monthstart=`expr $month - 2`
echo "month start is " $monthstart
#減過頭怎麼辦
monthanother=`expr $month - 12`
echo "month another is " $monthanother
