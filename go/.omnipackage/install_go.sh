#!/usr/bin/env bash

set -xEeuo pipefail

if go version; then
    exit 0
fi

curl -L https://go.dev/dl/go1.22.0.linux-amd64.tar.gz | tar -zx -C /usr/local
ln -s /usr/local/go/bin/* /usr/bin/
