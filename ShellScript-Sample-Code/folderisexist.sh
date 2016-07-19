#使用 -d 來判斷目錄是否存在
folderpath1="/home/nelsonchung/Develop/ShellScript-Sample-Code"
folderpath2="/home/nelsonchung/Develop/ShellScript-Sample-Code/Test"

echo "check the folder $folderpath1 is exist or not"

if [ -d "$folderpath1" ]; then
	echo "The folder is exist."
fi

echo "check the folder $folderpath2 is exist or not"

#注意!的使用
if [ ! -d "$folderpath2" ]; then
	echo "The folder is not exist."
fi


#Ref: http://hi.baidu.com/ryouaki/blog/item/e85af751c5c6252143a75b2a.html
#-r file　　　　　用户可读为真 
#-w file　　　　　用户可写为真 
#-x file　　　　　用户可执行为真 
#-f file　　　　　文件为正规文件为真 
#-d file　　　　　文件为目录为真 
#-c file　　　　　文件为字符特殊文件为真 
#-b file　　　　　文件为块特殊文件为真 
#-s file　　　　　文件大小非0时为真 
#-t file　　　　　当文件描述符(默认为1)指定的设备为终端时为真

#-n str1　　　　　　　 當串的長度大於0時為真(串非空)
#-z str1　　　　　　　 當串的長度為0時為真(空串) 
