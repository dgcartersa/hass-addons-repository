ARG BUILD_FROM
FROM $BUILD_FROM

ARG NIGHTSCOUT_VERSION=15.0.0

ENV LANG C.UTF-8
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && \
    apt-get -y --no-install-recommends \
    mongodb-server \
    nodejs \
    npm \
    webpack \
    git \
    python2.7 \
    nginx \
    libnginx-mod-http-lua

RUN apt-get autoremove -y
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --branch ${NIGHTSCOUT_VERSION} https://github.com/nightscout/cgm-remote-monitor.git /opt/app

RUN npm install \
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
