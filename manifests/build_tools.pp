# == Class: android::build_tools
#
# Installs the Android SDK build-tools.
#
# === Authors
#
# Philip Schiffer <philip.schiffer@gmail.com>
#
# === Copyright
#
# Copyright 2013 Philip Schiffer
#
define android::build_tools() {

  android::package{ $title:
    type => 'build-tools',
  }

}