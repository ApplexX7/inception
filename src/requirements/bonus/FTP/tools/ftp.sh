#!/bin/sh

FTP_PASSWD=$(cat /run/secrets/ft_user_password)

if ! id -u "$FTP_USER" >/dev/null 2>&1; then
	adduser -D -h "/home/$FTP_USER" "$FTP_USER"
	echo "$FTP_USER:$FTP_PASSWD" | chpasswd
	adduser "$FTP_USER" nobody
fi

# Make sure mount point exists
mkdir -p "/home/${FTP_USER}/data/html"

if [ ! -d "/var/www/html" ]; then
    echo "Missing /var/www/html. Ensure volume is mounted."
    exit 1
fi

rm -rf "/home/${FTP_USER}/data/html"
ln -s /var/www/html "/home/${FTP_USER}/data/html"

chown -h "${FTP_USER}:${FTP_USER}" "/home/${FTP_USER}/data/html"
chown -R "${FTP_USER}:${FTP_USER}" "/var/www/html"

grep -q "local_root=" /etc/vsftpd/vsftpd.conf || echo "local_root=/home/${FTP_USER}/data/html" >> /etc/vsftpd/vsftpd.conf

grep -q "force_dot_files=" /etc/vsftpd/vsftpd.conf || echo "force_dot_files=YES" >> /etc/vsftpd/vsftpd.conf
grep -q "seccomp_sandbox=" /etc/vsftpd/vsftpd.conf || echo "seccomp_sandbox=NO" >> /etc/vsftpd/vsftpd.conf

# Start FTP server
exec vsftpd /etc/vsftpd/vsftpd.conf

