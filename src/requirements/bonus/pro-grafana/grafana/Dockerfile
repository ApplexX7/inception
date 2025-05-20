FROM alpine:3.20

# Install Grafana and certificates
RUN apk add --no-cache grafana ca-certificates

# Set environment variable to define the home path for Grafana
ENV GF_PATHS_HOME=/etc/grafana

# Copy the custom grafana.ini to the appropriate location
COPY ./config/grafana.ini /etc/grafana/grafana.ini

COPY ./config/prometheus.yml /etc/grafana/provisioning/datasources/prometheus.yml

COPY ./config/dashboard.yml /etc/grafana/provisioning/dashboards/dashboard.yml
COPY ./config/cadvisor_grafana.json /etc/grafana/dashboards/cadvisor.json

COPY ./tools/script.sh .
RUN chmod +x script.sh

# Expose the Grafana port
EXPOSE 3000


# Set the entry point to start Grafana with the specified config
ENTRYPOINT ["grafana-server", "--homepath=/usr/share/grafana" ,"--config=/etc/grafana/grafana.ini"]

CMD ["/script.sh"]
