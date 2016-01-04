# == Define: android::addon
#
# Installs an Android SDK add-on package.
#
# === Examples
#
# To install an add-on package:
#   android::addon { 'addon-google_apis-google-16': }
#
# === Parameters
#
# [*revision*] The revision number of the specified add-on package or a value of
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
define android::addon(
  $revision = 'present',
) {

  android::package { $title:
    revision => $revision,
    type     => 'addon',
  }
}
