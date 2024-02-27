#!/usr/bin/env bash

set -xEeuo pipefail

BUILDROOT=$1
LIBDIR="/usr/lib/omnipackage_example_ruby"

ruby -v

install -d -m755 $BUILDROOT$LIBDIR
install -d -m755 $BUILDROOT/usr/bin/
cp -R $(ls -I ".omnipackage" -I ".gitignore" -I ".ruby-version" -I "node_modules" -I "debian") $BUILDROOT$LIBDIR

cd $BUILDROOT$LIBDIR/

mkdir -p .bundle
echo '---
BUNDLE_PATH: "vendor/bundle"
BUNDLE_WITHOUT: "development"
' >> .bundle/config

#gem install -i $BUILDROOT$LIBDIR/gems/ -N -E bundler
#$BUILDROOT$LIBDIR/gems/bin/bundle install --clean --path $BUILDROOT$LIBDIR/gems/
bin/setup

echo "
#!/usr/bin/env bash
cd $LIBDIR && bundle exec exe/omnipackage_example_ruby
" >> $BUILDROOT/usr/bin/omnipackage_example_ruby

chmod +x $BUILDROOT/usr/bin/omnipackage_example_ruby
