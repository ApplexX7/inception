FROM alpine:3.20

RUN apk add --no-cache vsftpd 

EXPOSE 21 21100-21110

COPY ./config/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./tools/ftp.sh /ftp.sh
RUN chmod +x /ftp.sh

ENTRYPOINT ["/ftp.sh"]
