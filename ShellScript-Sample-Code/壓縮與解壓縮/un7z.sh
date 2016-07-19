if [ -z $1 ];then
    echo "You need to input the file name."
    exit
fi
if [ -z $2 ];then
    7z x $1 -o./
fi
#decompress
7z x $1 -o$2
