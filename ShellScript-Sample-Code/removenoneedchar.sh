teststr=nelson/
echo "String is "$teststr
echo "Want to remove /"
resultstr=`echo $teststr | sed "s/\///g"`
echo "Result is "$resultstr
