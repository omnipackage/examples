#!/usr/bin/env bash

set -xEeuo pipefail

if crystal --version; then
  exit 0
fi

VERSION=1.16.3

curl -L https://github.com/crystal-lang/crystal/releases/download/$VERSION/crystal-$VERSION-1-linux-x86_64.tar.gz | tar -zx -C /usr/local
ln -s /usr/local/crystal-$VERSION-1/bin/* /usr/bin/
