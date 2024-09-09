#!/usr/bin/env bash

set -xEeuo pipefail

BUILDROOT=$1
ELECTRON_URL="https://github.com/electron/electron/releases/download/v29.0.1/electron-v29.0.1-linux-x64.zip"
LIBDIR="/usr/lib/omnipackage_example_electron"
APPDIR=$LIBDIR/resources/app/

install -d -m755 $BUILDROOT$APPDIR
wget --no-verbose -O electron.zip $ELECTRON_URL
unzip electron.zip -d $BUILDROOT$LIBDIR/
rm electron.zip
install -d -m755 $BUILDROOT/usr/bin/
cp -R $(ls -I ".omnipackage" -I ".gitignore" -I ".node-version" -I "node_modules" -I "debian" -I "share") $BUILDROOT$APPDIR
cp -R share/ $BUILDROOT/usr/
ln -sf $LIBDIR/electron $BUILDROOT/usr/bin/omnipackage_example_electron

chown -R root:root $BUILDROOT$LIBDIR
chmod -R 755 $BUILDROOT$LIBDIR
