source common.source

#set -xv

inputstring=$2
returnval=0
i=1
tmpnumber=1

if [ $1 -eq $STRING_INT_HUN ]; then  
while [ $i -le 5 ]
   do
        if [ $i -eq 1 ]; then
	   tmpnumber=`echo "$2" | cut -c$i-$i`
	   returnval=`expr $returnval + $tmpnumber \* 100` 
	   #returnval=`expr $i \* 100` 
        elif [ $i -eq 2 ]; then
	   tmpnumber=`echo "$2" | cut -c$i-$i`
	   returnval=`expr $returnval + $tmpnumber \* 10` 
        elif [ $i -eq 3 ]; then
	   tmpnumber=`echo "$2" | cut -c$i-$i`
	   returnval=`expr $returnval + $tmpnumber \* 1` 
        elif [ $i -eq 5 ]; then
	   tmpnumber=`echo "$2" | cut -c$i-$i`
	   returnval=`expr $returnval + $tmpnumber / 10` #小數點支援目前有問題 
        else
           returnval=$returnval
        fi 
        #echo "i = $i"
        #echo "return value is $returnval"
        i=`expr $i + 1`
   done
else
while [ $i -le 4 ]
   do
        if [ $i -eq 1 ]; then
	   tmpnumber=`echo "$2" | cut -c$i-$i`
	   returnval=`expr $returnval + $tmpnumber \* 10` 
	   #returnval=`expr $i \* 100` 
        elif [ $i -eq 2 ]; then
	   tmpnumber=`echo "$2" | cut -c$i-$i`
	   returnval=`expr $returnval + $tmpnumber \* 1` 
        elif [ $i -eq 4 ]; then
	   tmpnumber=`echo "$2" | cut -c$i-$i`
	   returnval=`expr $returnval + $tmpnumber / 10` #小數點支援目前有問題 
        else
           returnval=$returnval
        fi 
        #echo "i = $i"
        #echo "return value is $returnval"
        i=`expr $i + 1`
   done
fi
exit $returnval
