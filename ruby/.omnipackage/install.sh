#!/usr/bin/env bash

set -xEeuo pipefail

BUILDROOT=$1
LIBDIR="/usr/lib/omnipackage_example_ruby"
VENDORED_RUBY_DIR="/usr/lib/omnipackage_example_ruby/vendor/ruby"

install -d -m755 $BUILDROOT$LIBDIR
install -d -m755 $BUILDROOT/usr/bin/
cp -R $(ls -I ".omnipackage" -I ".gitignore" -I ".ruby-version" -I "node_modules" -I "debian") $BUILDROOT$LIBDIR

cd $BUILDROOT$LIBDIR/

mkdir -p .bundle
echo '---
BUNDLE_PATH: "vendor/bundle"
BUNDLE_WITHOUT: "development"
' >> .bundle/config

BUNDLER=bundle
if [ -d $VENDORED_RUBY_DIR ]; then
  mkdir -p $BUILDROOT$LIBDIR/vendor/
  cp -R $VENDORED_RUBY_DIR $BUILDROOT$LIBDIR/vendor/
  export PATH=$VENDORED_RUBY_DIR/bin/:$PATH
  BUNDLER=vendor/ruby/bin/bundle
fi

bin/setup

echo "
#!/usr/bin/env bash
cd $LIBDIR && $BUNDLER exec exe/omnipackage_example_ruby
" >> $BUILDROOT/usr/bin/omnipackage_example_ruby
chmod +x $BUILDROOT/usr/bin/omnipackage_example_ruby
