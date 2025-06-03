FROM alpine:3.20

RUN apk update && apk add --no-cache nginx openssl 

RUN mkdir /etc/nginx/ssl

RUN openssl req -x509 -nodes -subj "/C=MA/ST=KH/O=1337, Inc./CN=mohilali.42.fr" \
	-keyout /etc/nginx/ssl/inception.key -out /etc/nginx/ssl/inception.crt

COPY ./config/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/html

RUN chown -R nobody:nobody /var/www/html

CMD ["nginx", "-g", "daemon off;"]
