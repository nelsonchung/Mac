ls -al
echo "================================"
echo "當格式很標準(固定)"
echo "你利用下面方式,得到filename"
offset=61
ls -al | cut -c $offset-

echo "練習使用-d取出某字元後的字串"
echo "練習使用-f列出哪幾行"
echo $PATH
echo "================================"
for var in 1 2 3 4 5 6 7
do
	echo $PATH | cut -d ':' -f $var
done
