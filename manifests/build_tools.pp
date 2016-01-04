# == Define: android::build_tools
#
# Installs an Android SDK build-tools package.
#
# === Examples
#
# To install a build-tools package:
#   android::build_tools { 'build-tools-19.0.1': }
#
# === Authors
#
# Philip Schiffer <philip.schiffer@gmail.com>
#
# === Copyright
#
# Copyright 2013 Philip Schiffer.
#
define android::build_tools() {

  android::package { $title:
    type => 'build-tools',
  }
}
