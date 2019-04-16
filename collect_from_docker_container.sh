set -ex && mkdir -p ./build/release/bin
set -ex && docker create --name xtendcash-gui-container xtendcash-gui-image
set -ex && docker cp xtendcash-gui-container:/src/build/release/bin/ ./build/release/
set -ex && docker rm xtendcash-gui-container
