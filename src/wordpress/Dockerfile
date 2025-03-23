FROM debian:bullseye

RUN apt-get update -y 

RUN apt-get install -y curl php php7.4-fpm php-mysql mariadb-client

COPY ./wp.sh /

RUN mkdir -p /var/www/wordpress

RUN chmod +x wp.sh

#COPY ./wp-config.php /var/www/wordpress/wp-config.php

RUN chmod -R 755 /var/www/wordpress

ENTRYPOINT ["./wp.sh"]
