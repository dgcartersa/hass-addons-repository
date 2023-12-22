docker build --build-arg BUILD_FROM="ghcr.io/hassio-addons/ubuntu-base:8.2.1" --build-arg BUILD_ARCH=$1 --progress plain --no-cache -t dgcartersa/image-$1-addon-nightscout:$2 .
