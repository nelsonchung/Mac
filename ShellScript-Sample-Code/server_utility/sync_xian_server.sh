#!/bin/bash
###################################
# We can use the utility - rsync without sudo by following comment.
# Ref: http://love-love-l.blog.163.com/blog/static/21078304201071232234518/
# We can use the utility - rsync without input password.
# Ref: http://zbylovecool.blog.51cto.com/2515860/553636
###################################
source /home/nelson/server_utility/common.source

sync_process_count=`ps aux | grep sync_xian_server.sh | wc -l`
if [ $sync_process_count == "5" ]; then
    echo "This script have been launched before and not done yet. So exit."
    exit 2 
fi

email_title="Backup script to backup the source code from ${lh_server_ip} to ${xian_server_ip}"
#check svn backup script is done
while [ ! -e ${svndump_flag} ]
do
        echo "Not yet"
        sleep 600 # 1 min
done

#whatdayistoday=`date +%u`
##echo $whatdayistoday
#if [ $whatdayistoday -eq 7 ] ;then
#    #for full backup svn
#    backup_filename=${svn_full_backup_file_tag}.`date +%F`.gz
#    backup_path=${svn_full_backup_path}/${backup_filename} 
#    #wimax_archive=/var/public/wimax_archive/svn_full_bak
#    #backup_filename=weekly_fully_backup.svn.`date +%F`.gz
#    email_title="Full backup svn to xian server $xian_server_ip Result"
#    echo "Backup file will be store to ${backup_path}"
#    scp ${backup_path} nelson@${xian_server_ip}:${backup_path}     
#    if [ "$?" -ne "0" ]; then
#        email_body="${email_title} fail, something wrong!!!\n"
#        /usr/local/bin/sendEmail -f $from_email -t $to_email -xu $smtp_user -xp $smtp_pass -s $smtp_host -u $email_title -m "$email_body"
#        exit 1
#    fi
#else
#    #for increase backup svn
#    backup_filename=${svn_inc_backup_file_tag}.`date +%F`.gz
#    backup_path=${svn_inc_backup_path}/${backup_filename}
#    email_title="Increasement backup svn to xian server $xian_server_ip Result"
#    echo "Backup file will be store to ${wimax_archive}/${backup_filename}"
#    scp ${backup_path} nelson@${xian_server_ip}:${backup_path}     
#    if [ "$?" -ne "0" ]; then
#        email_body="${email_title} fail, something wrong!!!\n"
#        /usr/local/bin/sendEmail -f $from_email -t $to_email -xu $smtp_user -xp $smtp_pass -s $smtp_host -u $email_title -m "$email_body"
#        exit 1
#    fi
#fi 

#sync all data.
rsync -av -e "ssh -i ${ssh_certificate_key}" --progress --delete ${wimax_archive}/* ${backupuseraccount}@${xian_server_ip}:${wimax_archive}     
if [ "$?" -ne "0" ]; then
    email_title="${email_title} FAIL!!"
    log=`tail -n 100 ${log_file}`
    email_body="${email_title} fail, something wrong under rsync command!!!\nHere is the log\n\n${log}\n\n\nYou can reference the file from ${log_file} for more detail."
    /usr/local/bin/sendEmail -f $from_email -t $to_email -xu $smtp_user -xp $smtp_pass -s $smtp_host -u $email_title -m "$email_body"
    exit 1
fi
rsync -av -e "ssh -i ${ssh_certificate_key}" --progress --delete ${vplayer_archive}/* ${backupuseraccount}@${xian_server_ip}:${vplayer_archive}     
if [ "$?" -ne "0" ]; then
    email_title="${email_title} FAIL!!"
    log=`tail -n 100 ${log_file}`
    email_body="${email_title} fail, something wrong under rsync command!!!\nHere is the log\n\n${log}\n\n\nYou can reference the file from ${log_file} for more detail."
    /usr/local/bin/sendEmail -f $from_email -t $to_email -xu $smtp_user -xp $smtp_pass -s $smtp_host -u $email_title -m "$email_body"
    exit 1
fi

email_title="${email_title} OK!!"
email_body=""

# Send Email
#echo "/usr/local/bin/sendEmail -f $from_email -t $to_email -xu $smtp_user -xp $smtp_pass -s $smtp_host -u $email_title -m "$email_body""
/usr/local/bin/sendEmail -f $from_email -t $to_email -xu $smtp_user -xp $smtp_pass -s $smtp_host -u $email_title -m "$email_body" 

#You need to add ${backupuseraccount} into backup group under /etc/group
rm -f ${svndump_flag}
