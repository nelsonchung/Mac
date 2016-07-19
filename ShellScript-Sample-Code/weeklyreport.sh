####
# Version: 0.0.0.1
# Designed by Nelson
# 1. used for PBI
####
havemoreproject=1
havemorething=1
finishtime=2012/10/26
filename_output=weeklyreport.txt
count=1

filename_project=project.txt
filename_thing=thing.txt
filename_state=state.txt
filename_finishtime=finishtime.txt
filename_thingnextweek=thingnextweek.txt

## str
str_notyet="Not yet"

function init
{
    havemorething=1
    count=1
}

function outputdatechoose
{
    whatdayistoday=`date +%u`
    day_Mon=
    day_Tues=
    day_Wed=
    day_Thr=
    day_Fri=
    day_Sat=
    case ${whatdayistoday} in
        "5") # Today is Friday.
        day_Mon=`date -d "4 day ago" +%x`
        day_Tues=`date -d "3 day ago" +%x`
        day_Wed=`date -d "2 day ago" +%x`
        day_Thr=`date -d "1 day ago" +%x`
        day_Fri=`date +%x`
        echo "1. 週一:${day_Mon}"
        echo "2. 週二:${day_Tues}"
        echo "3. 週三:${day_Wed}"
        echo "4. 週四:${day_Thr}"
        echo "5. 週五:${day_Fri}"
        ;;
        "6") # Today is Saturday and we need to go to work today in the last week of month.
        day_Mon=`date -d "5 day ago" +%x`
        day_Tues=`date -d "4 day ago" +%x`
        day_Wed=`date -d "3 day ago" +%x`
        day_Thr=`date -d "2 day ago" +%x`
        day_Fri=`date -d "1 day ago" +%x`
        day_Sat=`date +%x`
        echo "1. 週一:${day_Mon}"
        echo "2. 週二:${day_Tues}"
        echo "3. 週三:${day_Wed}"
        echo "4. 週四:${day_Thr}"
        echo "5. 週五:${day_Fri}"
        echo "6. 週六:${day_Sat}"
        ;;
    esac
}
function outputchoose
{
    echo "如果有，請輸入1"
    echo "如果沒有，請輸入2"
}
function chooseproject
{
    # do some init here
    init
   
    echo "請選擇專案"
    echo "1. BM626e"
    echo "2. BM623m"
    echo "3. BM636e"
    echo "4. Other"
    read project
    
    case ${project} in
        "1")
        project=BM626e
        ;;
        "2")
        project=BM623m
        ;;
        "3")
        project=BM636e
        ;;
        *)
        echo "請輸入專案名稱"
        read project
        ;;
    esac

    echo "${count}. ${project}" >> ${filename_project}
}

function dosomethingonproject
{
    echo "請列出第${count}個項目"
    echo "${count}."
    read thing
    echo "${count}. ${thing}" >> ${filename_thing}
    
    dosomethingnextweek
    echo "還有其他項目嗎？"
    outputchoose
    read havemorething
    case ${havemorething} in
        "1")
        count=`expr ${count} + 1`
        ;;
        *)
        ;;
    esac
}

function finishdate
{
    echo "請選擇完成日期"
    outputdatechoose
    read finishtime

    case ${finishtime} in
        "1")
        echo "${count}. ${day_Mon}" >> ${filename_finishtime}
        ;;
        "2")
        echo "${count}. ${day_Tues}" >> ${filename_finishtime}
        ;;
        "3")
        echo "${count}. ${day_Wed}" >> ${filename_finishtime}
        ;;
        "4")
        echo "${count}. ${day_Thr}" >> ${filename_finishtime}
        ;;
        "5")
        echo "${count}. ${day_Fri}" >> ${filename_finishtime}
        ;;
        "6")
        echo "${count}. ${day_Sat}" >> ${filename_finishtime}
        ;;
    esac
}

function dosomethingnextweek
{
    echo "此項目是否有下週進度"
    outputchoose
    read thingnextweek
    case ${thingnextweek} in
        "1")
        echo "請輸入下週進度"
        read thingnextweek
        echo "${count}. Ongoing" >> ${filename_state}
        echo "${count}. ${str_notyet}" >> ${filename_finishtime}
        ;;
        "2")
        thingnextweek=None
        finishdate
        echo "${count}. Finished" >> ${filename_state}
#output None
        ;;
    esac

    echo "${count}. ${thingnextweek}" >> ${filename_thingnextweek}
}
function outputfile
{
    cat ${filename_project} >> ${filename_output}
    echo "===================" >> ${filename_output}
    cat ${filename_thing} >> ${filename_output}
    echo "===================" >> ${filename_output}
    cat ${filename_state} >> ${filename_output}
    echo "===================" >> ${filename_output}
    cat ${filename_finishtime} >> ${filename_output}
    echo "===================" >> ${filename_output}
    cat ${filename_thingnextweek} >> ${filename_output}
    echo "===================" >> ${filename_output}

    rm ${filename_project}
    rm ${filename_thing}
    rm ${filename_state}
    rm ${filename_finishtime}
    rm ${filename_thingnextweek}

    echo "*********************************************************" >> ${filename_output}
}

##main entry 
##clear date
rm ${filename_output}
while [ ${havemoreproject} -eq 1 ]; do
    chooseproject
    while [ ${havemorething} -eq 1 ]; do
        dosomethingonproject
    done
    echo "還有其他專案嗎？"
    outputchoose
    read havemoreproject
    outputfile
done

PWD=`pwd`
echo "請將${PWD}/${filename_output} 提供給 Nelson"
