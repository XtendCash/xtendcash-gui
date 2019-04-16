set -ex && mkdir -p ./build/release/bin
set -ex && docker create --name loki-gui-container loki-gui-image
set -ex && docker cp loki-gui-container:/src/build/release/bin/ ./build/release/
set -ex && docker rm loki-gui-container
