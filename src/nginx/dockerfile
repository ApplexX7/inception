FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade

RUN apt-get install nginx openssl -y

RUN mkdir /etc/nginx/ssl

RUN openssl req -x509 -nodes -subj "/C=CA/ST=QC/O=Company, Inc./CN=mydomain.com" \
	-keyout /etc/nginx/ssl/inception.key -out /etc/nginx/ssl/inception.crt

COPY ./nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/wordpress

RUN chown -R www-data:www-data /var/www/wordpress

CMD ["nginx", "-g", "daemon off;"]
