# == Define: android::platform
#
# Installs an Android SDK platform package.
#
# === Examples
#
# To install a platform package:
#   android::platform { 'android-16': }
#
# === Parameters
#
# [*revision*] The revision number of the specified platform package or a value
#   of 'latest' or 'present'
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
