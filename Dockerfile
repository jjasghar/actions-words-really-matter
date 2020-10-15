FROM bash:4.4

RUN apk add --no-cache the_silver_searcher sed

COPY entrypoint.sh .

ENTRYPOINT [ "bash", "/entrypoint.sh", "/source" ]
