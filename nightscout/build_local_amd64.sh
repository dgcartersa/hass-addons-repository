docker build --build-arg BUILD_FROM="ghcr.io/hassio-addons/ubuntu-base:8.1.1" --build-arg BUILD_ARCH=amd64 --progress plain --no-cache -t dgcartersa/image-amd64-addon-nightscout:$1 .
