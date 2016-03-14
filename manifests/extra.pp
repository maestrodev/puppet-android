# == Define: android::extra
#
# Installs an Android SDK extra package.
#
# === Examples
#
# To install an extra package:
#   android::extra { 'extra-google-play_billing': }
#
# === Parameters
#
# [*revision*] The revision number of the specified extra package or a value of
#   'latest' or 'present'
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
