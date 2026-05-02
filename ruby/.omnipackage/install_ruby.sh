#!/usr/bin/env bash

set -xEeuo pipefail

PREFIX=/usr/lib/omnipackage_example_ruby/vendor/ruby

if $PREFIX/bin/ruby -v; then
    exit 0
fi

curl -L https://cache.ruby-lang.org/pub/ruby/4.0/ruby-4.0.3.tar.gz | tar -zx -C .
cd ruby-*
./configure --disable-install-doc --prefix=$PREFIX
make -j$(nproc)
make install
cd ..
rm -rf ruby-*
ls -latrh $PREFIX
