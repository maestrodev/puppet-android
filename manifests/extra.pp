# == Define: android::extra
#
# Installs an Android SDK "extra's" package.
#
# === Authors
#
# Etienne Pelletier <epelletier@maestrodev.com>
#
# === Copyright
#
# Copyright 2012 MaestroDev, unless otherwise noted.
#
define android::extra(
  $revision = 'present',
) {

  android::package { $title:
    revision => $revision,
    type     => 'extra',
  }
}
