#!/usr/bin/env bash

set -xEeuo pipefail

BUILDROOT=$1
LIBDIR="/usr/lib/omnipackage_example_python"
PYTHON=python3
PIP=pip3

VENDORED_PYTHON_DIR="/usr/lib/omnipackage_example_python/vendorpython"

if [ -d $VENDORED_PYTHON_DIR ]; then
  mkdir -p $BUILDROOT$LIBDIR/
  cp -R $VENDORED_PYTHON_DIR $BUILDROOT$LIBDIR/
  export PATH=$VENDORED_PYTHON_DIR/bin/:$PATH
  PYTHON=vendorpython/bin/python3
  PIP=vendorpython/bin/pip3
fi

install -d -m755 $BUILDROOT$LIBDIR
install -d -m755 $BUILDROOT/usr/bin/
cp -R $(ls -I ".omnipackage" -I ".gitignore" -I ".python-version" -I "node_modules" -I "debian") $BUILDROOT$LIBDIR

cd $BUILDROOT$LIBDIR/

$PIP install --target ./vendorlibs --upgrade -r requirements.txt

echo "
#!/usr/bin/env bash
export PYTHONPATH=$LIBDIR/vendorlibs
cd $LIBDIR && $PYTHON main.py
" >> $BUILDROOT/usr/bin/omnipackage_example_python
chmod +x $BUILDROOT/usr/bin/omnipackage_example_python
