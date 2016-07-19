#顯示經過的秒數, 並附上顯示月份, 時, 分, 秒的方法
year=`date +%Y`
echo "year is " $year
month=`date +%m`
echo "month is " $month
hourstart=`date +%H`
echo "hour is " $hourstart
minstart=`date +%M`
secondstart=`date +%S`
echo "second start at " $secondstart
sleep 2
secondend=`date +%S`
echo "second end at " $secondend
diff=$(($secondend-$secondstart))
echo $diff
