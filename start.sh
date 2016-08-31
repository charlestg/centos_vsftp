#!/bin/bash

if ( id ${FTP_USER} ); then
  echo "User ${FTP_USER} already exists"
else
  echo "Creating user $FTP_USER"
  useradd -m -c "File Transfer User" -s /bin/bash $FTP_USER
  echo $FTP_USER:$FTP_PASS |chpasswd
  
  # Incase mount the drive from volume
  chown $FTP_USER:$FTP_USER /home/$FTP_USER
  
  echo "
allow_writeable_chroot=YES
anonymous_enable=NO
chroot_local_user=YES
connect_from_port_20=YES
dirmessage_enable=YES
ftpd_banner=$FTP_BANNER
listen=YES
local_enable=YES
no_anon_password=YES
pasv_addr_resolve=YES
pasv_address=$FTP_ADDRESS
pasv_enable=YES
pasv_max_port=$FTP_MAX_PORT
pasv_min_port=$FTP_MIN_PORT
port_enable=YES
seccomp_sandbox=NO
write_enable=YES
xferlog_enable=YES
#chown_username=$FTP_USER
#nopriv_user=$FTP_USER
background=NO
pam_service_name=vsftpd
" > /etc/vsftpd/vsftpd.conf
fi

exec $@
