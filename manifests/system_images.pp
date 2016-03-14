# == Define: android::system_images
#
# Installs an Android SDK system image package.
#
# === Examples
#
# To install a system image package:
#   android::system_images { 'sys-img-armeabi-v7a-android-23': }
#
# === Parameters
#
# [*revision*] The revision number of the specified system image package or a
#   value of 'latest' or 'present'
#
# === Authors
#
# Philip Schiffer <philip.schiffer@gmail.com>
#
# === Copyright
#
# Copyright 2013 Philip Schiffer, unless otherwise noted.
#
define android::system_images(
  $revision = 'present',
) {

  android::package { $title:
    revision => $revision,
    type     => 'system-images',
  }
}
