FROM alpine:3.20

# Install dependencies
RUN apk update && apk upgrade && \
    apk add --no-cache bash curl

# Install Netdata using the official kickstart script
RUN curl -Ss https://get.netdata.cloud/kickstart.sh > /tmp/kickstart.sh && \
    bash /tmp/kickstart.sh --dont-wait --dont-start-it && \
    rm /tmp/kickstart.sh

EXPOSE 19999

CMD ["/usr/sbin/netdata", "-D"]
