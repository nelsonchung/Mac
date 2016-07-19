#You can launch this by type

function testnelson() {
	if [ "$#" -le 3 ] ; then 
		return 22
	fi
}

#./getinputparam.sh test test1 test2
#It will show the amount of input parameter
echo $#
#It will show the content of input parameter
echo $@

testnelson

echo "show return value after call testnelson function"
echo $?
