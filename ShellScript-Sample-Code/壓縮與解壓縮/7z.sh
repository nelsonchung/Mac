
#compress
if [ -z $1 ];then
    echo "You need to input the file name."
    exit
fi
if [ -z $2 ];then
    echo "You need to input the path that you want to compress."
    exit
fi

7z a -mx=9 -mmt $1.7z $2
