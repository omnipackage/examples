#!/usr/bin/env bash

set -xEeuo pipefail

PREFIX=/usr/lib/omnipackage_example_python/vendorpython

if $PREFIX/bin/python3 -v; then
    exit 0
fi

curl -L https://www.python.org/ftp/python/3.12.2/Python-3.12.2.tar.xz | tar -Jx -C .
cd Python-3.12.2
./configure --disable-test-modules --prefix=$PREFIX
make -j$(nproc)
make install
cd ..
rm -rf Python-3.12.2
ls -latrh $PREFIX
