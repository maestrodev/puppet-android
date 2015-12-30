# == Define: android::platform
#
# Installs an Android SDK platform package.
#
# === Authors
#
# Etienne Pelletier <epelletier@maestrodev.com>
#
# === Copyright
#
# Copyright 2012 MaestroDev, unless otherwise noted.
#
define android::platform(
  $revision = 'present',
) {

  android::package { $title:
    revision => $revision,
    type     => 'platform',
  }
}
