#!/usr/bin/env bash

set -xEeuo pipefail

PREFIX=/usr/lib/omnipackage_example_ruby/vendor/ruby

if $PREFIX/bin/ruby -v; then
    exit 0
fi

curl -L https://cache.ruby-lang.org/pub/ruby/3.3/ruby-3.3.0.tar.gz | tar -zx -C .
cd ruby-3.3.0/
./configure --disable-install-doc --prefix=$PREFIX
make -j$(nproc)
make install
cd ..
rm -rf ruby-3.3.0/
ls -latrh $PREFIX
