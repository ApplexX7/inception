FROM alpine:3.20

RUN apk add --no-cache grafana ca-certificates bash

ENV GF_PATHS_HOME=/etc/grafana \
    GF_PATHS_CONFIG=/etc/grafana/grafana.ini \
    GF_PATHS_PROVISIONING=/etc/grafana/provisioning

RUN mkdir -p /etc/grafana/provisioning/datasources \
    && mkdir -p /etc/grafana/provisioning/dashboards \
    && mkdir -p /etc/grafana/dashboards

# Copy custom config files
COPY ./config/grafana.ini /etc/grafana/grafana.ini
COPY ./config/prometheus.yml /etc/grafana/provisioning/datasources/prometheus.yml
COPY ./config/dashboard.yml /etc/grafana/provisioning/dashboards/dashboard.yml
COPY ./config/cadvisor_grafana.json /etc/grafana/dashboards/cadvisor.json


EXPOSE 3000

ENTRYPOINT ["grafana-server", "--homepath=/usr/share/grafana", "--config=/etc/grafana/grafana.ini"]

