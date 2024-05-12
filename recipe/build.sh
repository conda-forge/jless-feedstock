#!/bin/bash

set -ex

if [[ "${target_platform}" == "osx-64" ]]; then
    export RUSTFLAGS="-C link-arg=-mmacosx-version-min=10.9"
fi

cargo-bundle-licenses \
    --format yaml \
    --output THIRDPARTY.yml

cargo install --locked --root "$PREFIX" --path .


# strip debug symbols
"$STRIP" "$PREFIX/bin/jless"

# remove extra build file
rm -f "${PREFIX}/.crates.toml"
