docker build --build-arg BUILD_FROM="ghcr.io/hassio-addons/ubuntu-base/aarch64:6.1.3" --build-arg BUILD_ARCH=aarch64 --progress plain --no-cache -t dgcartersa/image-aarch64-addon-nightscout:$1 .
