#使用 -f 來判斷檔案是否存在
path1="/home/nelsonchung/Develop/ShellScript-Sample-Code/folderisexist.sh"
path2="/home/nelsonchung/Develop/ShellScript-Sample-Code/test.sh"

echo "check the file $path1 is exist or not"

if [ -f "$path1" ]; then
	echo "The file is exist."
fi

echo "check the file $path2 is exist or not"

#注意!的使用
if [ ! -f "$path2" ]; then
	echo "The file is not exist."
fi


