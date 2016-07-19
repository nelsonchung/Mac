test(){
	#the mount of parameter
	#echo 
	#all parameter
	echo $@
	echo $1
	echo $2
}

test "test1" "test2"
#result of calling test function
echo $?
