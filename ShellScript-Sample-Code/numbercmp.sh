
#Ref:
#http://linux.vbird.org/linux_basic/0340bashshell-scripts.php
#4. 關於兩個整數之間的判定，例如 test n1 -eq n2
#-eq	兩數值相等 (equal)
#-ne	兩數值不等 (not equal)
#-gt	n1 大於 n2 (greater than)
#-lt	n1 小於 n2 (less than)
#-ge	n1 大於等於 n2 (greater than or equal)
#-le	n1 小於等於 n2 (less than or equal)

num1=5
num2=10

if [ $num1 -gt $num2 ] ;then
	echo $num1" 大於 "$num2
else
	echo $num1" 小於 "$num2
fi
