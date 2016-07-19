#count=`svn list http://172.18.1.5/svn/wimax/mt7119/branches/ | wc -l`
###############################################################
#
#	問題列表
#	1. 跨一個年會有問題 
#
#	未來目標
#	1. svn diff 輸入某一個rivision就與前一個修改對比
#
###############################################################
# 2012-11-06:  1. 加入svn blame 功能
# 2013-04-30:  1. 加上checkout功能
###############################################################

LOCALFOLDER=$pwd
PWD=http://10.118.251.18/ti-d3/
year=`date +%Y`
yearstart=$year
month=`date +%m`
monthdiff=2
monthstart=`expr $month - $monthdiff`
day=`date +%d`
day=`expr $day + 1`
oldPWD=http://172.18.1.5/svn/wmax/mt7119/
countLevel=0
PWDLIST[$countLevel]=$PWD

function Init()
{
	if [ $PWD != $oldPWD ];then
		svn list $PWD > /tmp/svnlist
	fi
	count=`cat /tmp/svnlist | wc -l`
}

function ReadFolderInfo()
{
	filename=/tmp/svnlist
	index=1
	while read line; do
	svnlist[$index]="$line"
	index=`expr $index + 1`
	done < $filename
}

function ShowPwd()
{
	
	echo "*****Current Path****"$PWD
	echo "*****Log time is*****"$year"/"$month"/"$day
}
function ShowEandLInfo()
{
	echo "'b': svn blame"
    echo "'c': checkout"
	echo "'d': svn diff"
	echo "'e': exit"
	echo "'L': show log with more infomation."
	echo "'l': show log"
	echo "'m': merge"
	echo "'n': adjust time to newer."
	echo "'o': adjust time to older."
	echo "'u': upper folder"
	ShowPwd
}

function ShowList()
{
	start=1
	end=`expr $count - 0`
	#read -p "Please choose the number you want to checkout now:" userinputnumber #將不會顯示下列選單
	echo "Please choose the number you want to show log now:"
	for i in $(seq $start $end)
	do
	number=`expr $i + 0`
	echo $number. ${svnlist[i]}
	done

	ShowEandLInfo
}


#選單式選擇要顯示log的目錄
#1. 顯示選單
#2. 任意進入任何目錄. 可以下一層, 上一層選擇目錄
#3. 選擇日期範圍. tortoisesvn 會先顯示100筆資訊後, 顯示一個預設日期. 可以參考.
while [ userinputnumber != "e" ]
do
	Init
	ReadFolderInfo
	ShowList


	read userinputnumber

	case $userinputnumber in
		b)
			svn blame $PWD
		;;
        c)
            svn checkout $PWD $LOCALFOLDER
        ;;
		e)
			break
		;;
		d)
			#echo "輸入revision開始處"
			echo "輸入revision"
			read rstart
			#echo "輸入revision結束處"
			#read rend
			revisiondiff=1
			rend=`expr $rstart - $revisiondiff`
			svn diff -r $rstart:$rend $PWD
		;;
		L)
			if [ $month -le 2 ]; then
				monthstart=`expr $month + 10`
				yearstart=`expr $year - 1`
			fi
			svn log -r {$yearstart-$monthstart-$day}:{$year-$month-$day} -v $PWD
		;;
		l)
			if [ $month -le 2 ]; then
				monthstart=`expr $month + 10`
				yearstart=`expr $year - 1`
			fi
			svn log -r {$yearstart-$monthstart-$day}:{$year-$month-$day} $PWD
		;;
		m)
			echo "輸入rivision開始處"
			read rstart
			echo "輸入rivision結束處"
			read rend	
			svn merge -r $rstart:$rend $PWD
		;;
		o)
			month=`expr $month - 2`
			monthstart=`expr $month - 2`
			#if [ $month < 0 ];then
			if [ $month -le 0 ];then
				month=`expr $month + 12`
				year=`expr $year - 1`
			fi
			#if [ $monthstart < 0 ];then
			if [ $monthstart -le 0 ];then
				monthstart=`expr $month + 12`
				yearstart=`expr $year - 1`
			fi
		;;
		n)
			month=`expr $month + 2`
			monthstart=`expr $month + 2`
			#if [ $month > 12 ];then
			if [ $month -gt 12 ];then
				month=`expr $month - 12`
				year=`expr $year + 1`
			fi
			#if [ $monthstart > 12 ];then
			if [ $monthstart -gt 12 ];then
				monthstart=`expr $month - 12`
				yearstart=`expr $year + 1`
			fi
		;;
		u)
			if [ $countLevel -ge 1 ];then
				countLevel=`expr $countLevel - 1`
				PWD=${PWDLIST[$countLevel]}
				echo "PWD is "$PWD
				oldPWD=http://172.18.1.5/
				echo "oldPWD is "$oldPWD
			else
				echo "已經到了根目錄嚕"
			fi
		;;
		*)
			#找出最後一個目錄名稱
			#foldername=`echo ${svnlist[$userinputnumber]} | sed "s/\///g"`
			#echo $foldername
			
			oldPWD=$PWD
			PWD=$PWD${svnlist[$userinputnumber]}
			
			countLevel=`expr $countLevel + 1`
			PWDLIST[$countLevel]=$PWD

		;;
	esac
	#echo $branchespath
	#echo $foldername
	#svn checkout $branchespath $foldername-$month$day
	
#echo $userinputnumber $month$day
done
