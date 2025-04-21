FROM alpine:3.20

RUN apk update && apk add --no-cache redis

COPY redis.conf /etc/redis.conf

EXPOSE 6379

CMD ["redis-server"]
