#!/usr/bin/env bash

set -xEeuo pipefail

if crystal --version; then
  exit 0
fi

curl -L https://github.com/crystal-lang/crystal/releases/download/1.15.1/crystal-1.15.1-1-linux-x86_64.tar.gz | tar -zx -C /usr/local
ln -s /usr/local/crystal-1.15.1-1/bin/* /usr/bin/
