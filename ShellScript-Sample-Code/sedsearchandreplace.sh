PWD=`pwd`
echo $PWD

#將/部份取代不要
result=`echo $PWD | sed "s/\///g"`
echo $result
