oristr="test"
cmpstr1="test1"
cmpstr2="test2"
if [ $oristr = $cmpstr1 ] || [ $oristr = $cmpstr2 ] ;then
	echo "it is the same"
else
	echo "not the same"
fi
