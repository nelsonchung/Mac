#使用 -f 來判斷檔案是否存在
path1="/home/nelsonchung/Develop/ShellScript-Sample-Code/folderisexist.sh"
path2=""

echo "check the param $path1 has value or not."

if [ -n "$path1" ]; then
	echo "The param has value."
fi

echo "check the file $path2 has value or not"

#注意!的使用
if [ ! -n "$path2" ]; then
	echo "The file has no value."
fi


