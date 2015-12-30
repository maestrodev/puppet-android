# == Class: android::system_images
#
# Installs the Android SDK system-images.
#
# === Authors
#
# Philip Schiffer <philip.schiffer@gmail.com>
#
# === Copyright
#
# Copyright 2013 Philip Schiffer
#
define android::system_images(
  $revision = 'present',
) {

  android::package { $title:
    revision => $revision,
    type     => 'system-images',
  }
}
