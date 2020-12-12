FROM rust:1.48

RUN apt-get update && \
    apt-get install -y wget && \
    apt-get install -y git

RUN cargo install md-inc

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "sh", "-c", "/entrypoint.sh" ]
