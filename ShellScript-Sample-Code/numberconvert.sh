echo "選擇要做的數字轉換"
echo "1. 2進制轉10進制"
#echo "2. 2進制轉16進制"
echo "3. 10進制轉2進制"
echo "4. 10進制轉16進制"
echo "5. 16進制轉2進制"
#echo "6. 16進制轉10進制"
read num
echo "請輸入數字"
read number

if [ $num -eq 1 ];then
    ibase=2
    obase=A
    #obase=10#轉換失敗
#elif [ $num -eq 2 ];then
#    ibase=2
    #obase=F#轉換失敗
    #obase=16#轉換失敗
elif [ $num -eq 3 ];then
    ibase=10
    obase=2
elif [ $num -eq 4 ];then
    ibase=10
    obase=16
elif [ $num -eq 5 ];then
    ibase=16
    obase=2
#elif [ $num -eq 6 ];then #have problem with bc
#    ibase=16
#    obase=10
fi

echo "ibase=${ibase};obase=${obase};${number}" | bc
