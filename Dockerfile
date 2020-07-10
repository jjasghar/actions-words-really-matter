FROM alpine:latest

RUN apk add the_silver_searcher sed

COPY entrypoint.sh /

WORKDIR /mnt

ENTRYPOINT ["/entrypoint.sh"]
