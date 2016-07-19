echo "練習sed"
echo "可以使用sed來取代, 刪除, 新增, 與擷取特定行等功能"

echo "ls -al"
ls -al
echo "練習刪除"
echo "ls -al | sed '1,3d'"
ls -al | sed '1,3d'

echo "練習新增"
echo " ls -al | sed '1,3d' | sed '1a test'"
ls -al | sed '1,3d' | sed '1a practice add'

echo "練習取代"
echo "ls -al | sed '1,3d' | sed '2,5c practice replace'"
ls -al | sed '1,3d' | sed '2,5c practice replace'

echo "練習顯示"
echo "請注意要有-n的存在"
echo "ls -al | sed '1,3d' | sed -n '2,5p'"
ls -al | sed '1,3d' | sed -n '2,5p'

echo "顯示filename"
ls -al | sed '1,3d' | sed -n '2,5p' | cut -c 61- 
#Ref: http://linux.vbird.org/linux_basic/0330regularex.php#sed
