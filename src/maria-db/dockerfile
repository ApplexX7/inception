FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade

RUN apt install mariadb-server -y

COPY ./mydb-config.sh /mydb-config.sh

RUN  chmod +x mydb-config.sh

CMD ["./mydb-config.sh"]
