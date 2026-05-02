#!/usr/bin/env bash

set -xEeuo pipefail

PREFIX=/usr/lib/omnipackage_example_python/vendorpython

if $PREFIX/bin/python3 -v; then
    exit 0
fi

PYTHON_VERSION="3.14.4"

curl -L https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tar.xz | tar -Jx -C .
cd Python-$PYTHON_VERSION
./configure --disable-test-modules --prefix=$PREFIX
make -j$(nproc)
make install
cd ..
rm -rf Python-$PYTHON_VERSION
ls -latrh $PREFIX
