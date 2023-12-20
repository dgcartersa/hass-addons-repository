ARG BUILD_FROM=ghcr.io/hassio-addons/ubuntu-base:8.1.1
FROM $BUILD_FROM

ARG NIGHTSCOUT_VERSION=15.0.0
ARG NODE_MAJOR=16

ENV LANG C.UTF-8

RUN mkdir -p /opt/app
WORKDIR /opt/app

RUN URL="http://archive.ubuntu.com/ubuntu/" \
    && if [ "${BUILD_ARCH}" = "aarch64" ]; then \
        URL="http://ports.ubuntu.com/ubuntu-ports/"; \
    fi \
    && echo "deb ${URL} bionic universe" > /etc/apt/sources.list.d/bionic-universe.list \
    && echo "deb ${URL} bionic main" > /etc/apt/sources.list.d/bionic-main.list

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    mongodb-server \
    nodejs \
    webpack \
    git

RUN apt-get autoremove -y
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --branch ${NIGHTSCOUT_VERSION} https://github.com/nightscout/cgm-remote-monitor.git /opt/app

RUN cd /opt/app \
    && npm install \
    && npm run postinstall \
    && npm run env \
    && npm audit fix

VOLUME ["/data/db"]

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Nightscout" \
    io.hass.description="Nightscout acts as a web-based CGM (Continuous Glucose Montinor) to allow multiple caregivers to remotely view a patients glucose data in realtime." \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Darren Carter" \
    org.opencontainers.image.title="Nightscout" \
    org.opencontainers.image.description="Nightscout acts as a web-based CGM (Continuous Glucose Montinor) to allow multiple caregivers to remotely view a patients glucose data in realtime." \
    org.opencontainers.image.vendor="Darren Carter" \
    org.opencontainers.image.authors="Darren Carter" \
    org.opencontainers.image.licenses="GNUv3" \
    org.opencontainers.image.source="https://github.com/dgcartersa/addon-nightscout" \
    org.opencontainers.image.documentation="https://github.com/dgcartersa/addon-nightscout/blob/master/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
