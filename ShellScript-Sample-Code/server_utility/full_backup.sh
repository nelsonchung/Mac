#!/bin/sh
#wimax_archive=/home/public/wimax_archive/full_bak
wimax_archive=/var/public/wimax_archive/svn_full_bak
backup_filesource=/home/svn/repos/wimax
smtp_host=172.18.1.6
smtp_user=primesw
smtp_pass=A5696D51EE
to_email="double_chiang@pesi.com.tw,lance_wu@pesi.com.tw,yfchen@pesicn.com,htliu@pesicn.com,lliu@pesicn.com"
#to_email="lliu@pesicn.com"
from_email="lliu@pesicn.com"
backup_filename=weekly_fully_backup.svn.`date +%F`.gz

email_title="Full backup svn to xian server 192.168.210.218 Result"
youngest=`svnlook youngest $backup_filesource`

function purge_archive() {

    MAXNUM=3
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

echo "Backup file will be store to ${wimax_archive}/${backup_filename}"
umask g=rw
svnadmin dump $backup_filesource | gzip > ${wimax_archive}/${backup_filename} 

purge_archive weekly_fully_backup.svn.*

if [ "$?" -ne "0" ]; then
  email_body="Can not generate backup file, something wrong!!!\n"
  /usr/local/bin/sendEmail -f $from_email -t $to_email -xu $smtp_user -xp $smtp_pass -s $smtp_host -u $email_title -m "$email_body"
  exit 1
fi

chgrp backup ${wimax_archive}/${backup_filename}
scp ${wimax_archive}/${backup_filename} liulei@192.168.210.218:${wimax_archive}/${backup_filename} 
if [ "$?" -ne "0" ]; then
  email_body="Can not send backup file ${wimax_archive}/${backup_filename} to 192.168.210.218, something wrong!!!\n"
  /usr/local/bin/sendEmail -f $from_email -t $to_email -xu $smtp_user -xp $smtp_pass -s $smtp_host -u $email_title -m "$email_body"
  exit 1
fi

rm -f ${wimax_archive}/${backup_filename}

echo "$youngest" > ${wimax_archive}/../LOG

email_body="Backup script to backup the source code from 172.18.1.5 to 192.168.210.218 successfully!\n"
email_body="${email_body}Generated backup file is ${wimax_archive}/${backup_filename}\n"

# Send Email
/usr/local/bin/sendEmail -f $from_email -t $to_email -xu $smtp_user -xp $smtp_pass -s $smtp_host -u $email_title -m "$email_body" 

