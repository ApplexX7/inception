FROM alpine:3.20
RUN apk add --no-cache grafana ca-certificates
COPY grafana.ini /etc/grafana/grafana.ini
EXPOSE 3000
ENTRYPOINT ["grafana-server", "--config=/etc/grafana/grafana.ini"]

