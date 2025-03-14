FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade

RUN apt-get install -y curl php php7.4-fpm php-mysql mariadb-client

COPY ./wp.sh /

RUN chmod +x wp.sh

ENTRYPOINT ["./wp.sh"]
