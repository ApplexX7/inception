FROM alpine:3.20

RUN apk update && apk add --no-cache python3

COPY ./tools/ ./tools

WORKDIR /tools

ENTRYPOINT ["python3", "-m", "http.server", "8000"]

