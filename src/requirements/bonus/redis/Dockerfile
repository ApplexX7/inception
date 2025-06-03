FROM alpine:3.20

RUN apk update && apk add --no-cache redis

ENTRYPOINT ["redis-server", "--protected-mode", "no", "--maxmemory", "256mb", "--maxmemory-policy", "allkeys-lru"]
