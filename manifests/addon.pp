# == Define: android::addon
#
# Installs an Android SDK add-on package.
#
# === Authors
#
# Etienne Pelletier <epelletier@maestrodev.com>
#
# === Copyright
#
# Copyright 2012 MaestroDev, unless otherwise noted.
#
define android::addon(
  $revision = 'present',
) {

  android::package { $title:
    revision => $revision,
    type     => 'addon',
  }
}
