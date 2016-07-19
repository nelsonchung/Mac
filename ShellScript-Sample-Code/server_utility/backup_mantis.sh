#!/bin/bash
logfile=backupmantis.log
wimax_archive=/home/archive/wimax_archive/mantis
smtp_host=172.18.1.6
smtp_user=primesw
smtp_pass=pesiprime
to_email="double_chiang@pesi.com.tw lenny@pesicn.com"
from_email=`whoami`@pesicn.com
backup_filename=mantis.sql.`date +%F`.gz
final_place=$wimax_archive/$backup_filename
email_title="Mantis Daily Backup Result"

# Used to purge specified directory
# \param $1 is the purge file pattern
function purge_archive() {

    MAXNUM=30
    current_directory=`pwd`
    cd $wimax_archive
    amount=`ls -l $1 2>/dev/null | wc -l`
    if [ ${amount} -gt "$MAXNUM" ]; then
	purge_num=`expr $amount  - $MAXNUM`
	purge_file=`ls $1 2>/dev/null | head --line=$purge_num`
	rm $purge_file
    fi

    echo "Some files are removed in order to make room in the directory!"
    cd $current_directory
}


echo "Backup file will be store to $backup_filename"

mysqldump --opt -uroot -ppesiprime mantis > $backup_filename

# Check the return status of previous command
if [ "$?" -ne "0" ]; then
  echo "Can not generate backup file, something wrong!!!"
  exit 1
fi 
mv $backup_filename $final_place -f
purge_archive mantis.sql.*
email_body="Backup script to backup the mantis server.\n"
email_body="${email_body}Generated backup file is \n"
email_body="${email_body}`ls -ls $final_place`\n"
email_body="${email_body}--------total files listed in the directory----------------\n"
email_body="${email_body}`ls -l $wimax_archive/*`\n"


/usr/local/bin/sendEmail -f $from_email -t $to_email -xu $smtp_user -xp $smtp_pass -s $smtp_host -u $email_title -m "$email_body" 




