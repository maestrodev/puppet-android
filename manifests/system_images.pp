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
define android::system_images($expected_path = undef) {

  android::package{ $title:
    type          => 'system-images',
    expected_path => $expected_path,
  }

}
