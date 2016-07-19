#!/bin/sh
logfile=backupsvn.log
#wimax_archive=/home/public/wimax_archive
wimax_archive=/var/public/wimax_archive
backup_filesource=/home/svn/repos/wimax
smtp_host=172.18.1.6
smtp_user=primesw
smtp_pass=A5696D51EE
#to_email="double_chiang@pesi.com.tw,lance_wu@pesi.com.tw,yfchen@pesicn.com,lliu@pesicn.com"
to_email="lliu@pesicn.com"
from_email=`whoami`@pesicn.com
backup_filename=wimax.svn.`date +%F`.gz
final_place=$wimax_archive/$backup_filename

email_title="Daily Backup Result"

echo "Backup file will be store to $backup_filename"
umask g=rw
svnadmin dump $backup_filesource | gzip > $backup_filename 
if [ "$?" -ne "0" ]; then
  echo "Can not generate backup file, something wrong!!!"
  exit 1
fi
chgrp backup $backup_filename
mv $backup_filename $final_place -f
# change the group and mask setting

MAXNUM=30
cd $wimax_archive
amount=`ls -l wimax.svn.* 2>/dev/null | wc -l`
while [ "${amount}" -gt "$MAXNUM" ]
do
  fname=`echo wimax.svn.*`
  set $fname
  rm -r $1
  amount=`expr $amount - 1`
done
echo "Some files are removed in order to make room in the directory!"

email_body="Backup script to backup the source code on server.\n"
email_body="${email_body}Generated backup file is \n"
email_body="${email_body}`ls -ls $final_place`\n"
# email_body="${email_body}--------total files listed in the directory, it's HUGE, remember to purge it----------------\n"
email_body="${email_body}--------total files listed in the directory, it's HUGE, in order to make room in the directory, we removed the files which were generated 30 days ago. \n"
email_body="${email_body}`ls -l $wimax_archive/*`\n"

/usr/local/bin/sendEmail -f $from_email -t $to_email -xu $smtp_user -xp $smtp_pass -s $smtp_host -u $email_title -m "$email_body" 

