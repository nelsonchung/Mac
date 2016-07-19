nullstring=""
teststring="testandtest"

#使用test -n 會有錯誤
if test -n $teststring
	then echo "It is null string"
else
	echo "It is not null string"
fi

#使用 test -z 則判斷空字串沒問題
if test -z $nullstring
	then echo "It is null string"
else
	echo "It is not null string"
fi
if test -z $teststring
	then echo "It is null string"
else
	echo "It is not null string"
fi
