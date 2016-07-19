#使用 -f 來判斷檔案是否存在
path1="/home/nelsonchung/Develop/ShellScript-Sample-Code/folderisexist.sh"
path2="/home/nelsonchung/minicom.log"

echo "check the file $path1 is executable or not"

if [ -x "$path1" ]; then
	echo "The file is executable."
fi

echo "check the file $path2 is executalbe or not"

#注意!的使用
if [ ! -x "$path2" ]; then
	echo "The file is not executable."
fi


