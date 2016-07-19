#!/bin/bash
source /home/nelson/server_utility/common.source

#Ref: http://ubuntuforums.org/showthread.php?t=499045
purge_archive()
{
    MAXNUM=$3
    current_directory=`pwd`
    cd $1
    amount=`ls -l $2 2>/dev/null | wc -l`
    if [ ${amount} -gt "$MAXNUM" ]; then
        purge_num=`expr $amount  - $MAXNUM`
        purge_file=`ls $2 2>/dev/null | head --line=$purge_num`
        rm $purge_file
    fi

    echo "Some files are removed in order to make room in the directory!"
    cd $current_directory
}
svndone() {
echo "svndone" > ${svndump_flag} 
chgrp backup ${revision_log}
chgrp backup ${svndump_flag}
}

do_full_backup=0
if [ ! -e ${revision_log} ] ;then
    do_full_backup=1
fi

youngest=`svnlook youngest $backup_filesource`

whatdayistoday=`date +%u`
if [ $whatdayistoday -eq 7 -o $do_full_backup -eq "1" ] ;then
    #full backup svn
    backup_filename=${svn_full_backup_file_tag}.`date +%F`.gz
    backup_path=${svn_full_backup_path}/${backup_filename}
    email_title="Full backup svn to xian server $xian_server_ip Result"
    echo "Backup file will be store to ${backup_path}"
    umask g=rw
    svnadmin dump $backup_filesource | gzip > ${backup_path} 
    chgrp backup ${backup_path}
    #Now, we keep the full svn backup date with three weeks
    purge_archive ${svn_full_backup_path} ${svn_full_backup_file_tag}.* 3
    if [ "$?" -ne "0" ]; then
        email_body="Can not generate backup file, something wrong!!!\n"
        /usr/local/bin/sendEmail -f $from_email -t $to_email -xu $smtp_user -xp $smtp_pass -s $smtp_host -u $email_title -m "$email_body"
        exit 1
    fi
else
    #increase backup svn
    backup_filename=${svn_inc_backup_file_tag}.`date +%F`.gz
    backup_path=${svn_inc_backup_path}/${backup_filename}
    email_title="Increasement backup svn to xian server $xian_server_ip Result"
    echo "Backup file will be store to ${backup_path}"
    if [ ! -e ${revision_log} ] ; then
        email_body="Please act Weekly Fully Backup First!\n"
        echo ${email_body}
        /usr/local/bin/sendEmail -f $from_email -t $to_email -xu $smtp_user -xp $smtp_pass -s $smtp_host -u $email_title -m "$email_body"
        exit 1
    fi
    previous=`cat ${revision_log}`
    purge_archive ${svn_inc_backup_path} ${svn_inc_backup_file_tag}.* 15 

    if [ "$youngest" = "$previous" ] ; then
        email_body="No new revisions to backup.\n"
        echo ${email_body}
        /usr/local/bin/sendEmail -f $from_email -t $to_email -xu $smtp_user -xp $smtp_pass -s $smtp_host -u $email_title -m "$email_body" 
        svndone
        exit 1
    fi
    first_rev=`expr $previous + 1`
    umask g=rw
    svnadmin dump --incremental --revision $first_rev:$youngest $backup_filesource | gzip > ${backup_path}
    chgrp backup ${backup_path}
    if [ "$?" -ne "0" ]; then
        echo ${email_body}
        email_body="Can not generate backup file, something wrong!!!\n"
        /usr/local/bin/sendEmail -f $from_email -t $to_email -xu $smtp_user -xp $smtp_pass -s $smtp_host -u $email_title -m "$email_body"
        exit 1
    fi
fi

#update revision number for backup.
echo "$youngest" > ${revision_log}
svndone

email_body="Backup file will be store to ${backup_path} successfully"

# Send Email
/usr/local/bin/sendEmail -f $from_email -t $to_email -xu $smtp_user -xp $smtp_pass -s $smtp_host -u $email_title -m "$email_body" 

