# === Class: android::paths
#
# This class defines the paths used in the Android SDK installation
# and operation.
#
# === Authors
#
# Etienne Pelletier <epelletier@maestrodev.com>
#
# === Copyright
#
# Copyright 2012 MaestroDev, unless otherwise noted.
#
class android::paths{

  $installdir = $android::installdir
  $version = $android::version

  case $::kernel {
    'Linux': {
      if ! defined(File['/usr/local/src']) {
        file { '/usr/local/src':
          ensure => directory,
        }
      }
      $sdk_home = "${installdir}/android-sdk-linux"
      $source = "http://dl.google.com/android/android-sdk_r${version}-linux.tgz"
      $archive = "/usr/local/src/android-sdk_r${version}-linux.tgz"
    }
    'Darwin': {
      $source = "http://dl.google.com/android/android-sdk_r${version}-macosx.zip"
      $sdk_home = "${installdir}/android-sdk-macosx"
      $archive = "${installdir}/android-sdk_r${version}-macosx.zip"
    }
    default: {
      fail("Unsupported Kernel: ${::kernel} operatingsystem: ${::operatingsystem}")
    }
  }
}