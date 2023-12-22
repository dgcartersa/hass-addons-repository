ARG BUILD_FROM
FROM $BUILD_FROM

# Variables
ARG NIGHTSCOUT_VERSION=15.0.0
ARG NODE_MAJOR=16

ENV LANG C.UTF-8

# Working folders
RUN mkdir -p /opt/app
WORKDIR /opt/app

# Repository Setup
RUN apt-get update && apt-get install -y --no-install-recommends gnupg
RUN curl -fsSL https://pgp.mongodb.com/server-7.0.asc | gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg -o /etc/apt/keyrings/nodesource.gpg --dearmor \
    && echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-7.0.list \
    && echo "deb [ arch=amd64,arm64 signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list

# Package installation
RUN apt update && apt install -y --no-install-recommends \
    mongodb-org \
    nodejs \
    git

# Nightscout Installation
RUN git clone --depth 1 --branch ${NIGHTSCOUT_VERSION} https://github.com/nightscout/cgm-remote-monitor.git /opt/app

RUN cd /opt/app \
    && npm install

# Configure Volumes
VOLUME ["/data/db"]

# Copy Root Filesystem
COPY rootfs /

# Build Arguments
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