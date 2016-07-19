#!/bin/bash
source /home/nelson/server_utility/common.source

logfile=backupredmine.log
backup_filename=redmine.sql.`date +%F`.gz
backup_path=${redmine_archive}/$backup_filename
email_title="Redmine Daily Backup Result"

# Used to purge specified directory
# \param $1 is the purge file pattern
function purge_archive() {

    MAXNUM=30
    current_directory=`pwd`
    cd $redmine_archive
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

# backup database
umask g=rw
mysqldump --opt -u root -ppesiprime redmine | gzip > $backup_filename
chgrp backup $backup_path
# backup attachements
rsync -a ${redmine_attchment_path} ${redmine_attachment_archive}
# Check the return status of previous command
if [ "$?" -ne "0" ]; then
  echo "Can not generate backup file, something wrong!!!"
  exit 1
fi 
mv $backup_filename $backup_path -f

purge_archive redmine.sql.*

#email_body="Backup script to backup the mantis server.\n"
#email_body="${email_body}Generated backup file is \n"
#email_body="${email_body}`ls -ls $backup_path`\n"
#email_body="${email_body}--------total files listed in the directory----------------\n"
#email_body="${email_body}`ls -l $redmine_archive/*`\n"

#/usr/local/bin/sendEmail -f $from_email -t $to_email -xu $smtp_user -xp $smtp_pass -s $smtp_host -u $email_title -m "$email_body" 

# Send to xian server
#email_title="Backup redmine to xian server ${xian_server_ip} Result"
#scp ${backup_path} nelson@${xian_server_ip}:${backup_path}
#if [ "$?" -ne "0" ]; then
#  email_body="Can not send backup file ${backup_path} to ${xian_server_ip}, something wrong!!!\n"
#  /usr/local/bin/sendEmail -f $from_email -t $to_email -xu $smtp_user -xp $smtp_pass -s $smtp_host -u $email_title -m "$email_body"
#  exit 1
#fi

email_body="${email_title} - OK!\n"
email_body="${email_body}Generated backup file is ${backup_path}\n"

# Send Email
/usr/local/bin/sendEmail -f $from_email -t $to_email -xu $smtp_user -xp $smtp_pass -s $smtp_host -u $email_title -m "$email_body"

