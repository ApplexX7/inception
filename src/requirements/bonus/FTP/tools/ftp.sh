#!/bin/sh

if ! id -u "$FTP_USER" >/dev/null 2>&1; then
	adduser -D -h "/home/$FTP_USER" "$FTP_USER"
	echo "$FTP_USER:$FTP_PASSWD" | chpasswd
	adduser "${FTP_USER}" nobody

	mkdir -p "/home/${FTP_USER}/wordpress_files"
	chown -R "${FTP_USER}:${FTP_USER}" "/home/${FTP_USER}"

	grep -q "local_root=" /etc/vsftpd/vsftpd.conf || echo "local_root=/home/${FTP_USER}/wordpress_files" >> /etc/vsftpd/vsftpd.conf
fi


exec vsftpd /etc/vsftpd/vsftpd.conf
