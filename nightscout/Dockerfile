ARG BUILD_FROM
FROM $BUILD_FROM

# Variables
ARG NIGHTSCOUT_VERSION=15.0.0
ARG NODE_MAJOR=16

ENV LANG C.UTF-8

# Node Swtup
RUN cd /tmp \
    && curl -SLO https://deb.nodesource.com/nsolid_setup_deb.sh \
    && chmod 500 nsolid_setup_deb.sh \
    && ./nsolid_setup_deb.sh 16

# Package installation
RUN apt-get update && apt-get install -y --no-install-recommends \
    mongodb-server \
    nodejs \
    git

# Working folders
RUN mkdir -p /opt/app
WORKDIR /opt/app

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