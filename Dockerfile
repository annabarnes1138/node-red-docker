FROM lsiobase/alpine:3.12

ARG MOSQUITTO_AUTH_VERSION=0.1.4

LABEL maintainer="Steven Barnes" \
    description="Eclipse Mosquitto MQTT Broker"

ENV VERSION=1.6.9 \
    MOSQUITTO_AUTH_VERSION=${MOSQUITTO_AUTH_VERSION}

WORKDIR /usr/src

# Copy root filesystem
COPY rootfs /

RUN apk add --no-cache \
        curl \
        mosquitto \
        musl \
        openssl \
        pwgen \
        socat \
        jq && \
    apk add --no-cache --virtual .build-dependencies \
        build-base \
        curl-dev \
        git \
        mosquitto-dev \
        openssl-dev && \
    git clone --depth 1 -b "${MOSQUITTO_AUTH_VERSION}" \
        https://github.com/pvizeli/mosquitto-auth-plug && \
    cd mosquitto-auth-plug && \
    cp config.mk.in config.mk && \
    make && \
    mkdir -p /usr/share/mosquitto && \
    cp -f auth-plug.so /usr/share/mosquitto && \
    apk del .build-dependencies && \
    rm -fr /usr/src/mosquitto-auth-plug && \
    mkdir -p /mosquitto/config /mosquitto/data /mosquitto/log && \
    cp /etc/mosquitto/mosquitto.conf /mosquitto/config/mosquitto.conf && \
    cp /etc/mosquitto/include_dir.conf /mosquitto/include_dir.conf

VOLUME ["/mosquitto/data", "/mosquitto/log"]

EXPOSE 1883
ENTRYPOINT ["/init"]
