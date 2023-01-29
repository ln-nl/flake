#!/usr/bin/env bash
set -eu -o pipefail

rm -f node-env.nix
node2nix -i node-packages.json -o node-packages.nix -c composition.nix --pkg-name nodejs-18_x
