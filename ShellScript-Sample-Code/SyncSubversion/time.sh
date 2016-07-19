#顯示經過的秒數, 並附上顯示月份, 時, 分, 秒的方法
month=`date +%m`
hourstart=`date +%H`
minstart=`date +%M`
secondstart=`date +%S`
sleep 2
secondend=`date +%S`
diff=$(($secondend-$secondstart))
echo $diff
