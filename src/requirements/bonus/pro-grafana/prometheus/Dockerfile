FROM alpine:3.20

RUN apk update && apk add --no-cache prometheus

COPY ./config/prometheus.yml /etc/prometheus/prometheus.yml

#RUN rc-update add prometheus default
#RUN rc-service prometheus start

EXPOSE 9000

ENTRYPOINT ["prometheus", \
  "--config.file=/etc/prometheus/prometheus.yml", \
  "--storage.tsdb.path=/var/lib/prometheus"]
