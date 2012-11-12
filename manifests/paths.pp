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
      $installdir_real = $installdir ? { 'UNSET' => '/usr/local/android', default => $installdir }
      $sdk_home = "${installdir_real}/android-sdk-linux"
      $source = "http://dl.google.com/android/android-sdk_r${version}-linux.tgz"
      $archive = "/usr/local/src/android-sdk_r${version}-linux.tgz"
    }
    'Darwin': {
      $source = "http://dl.google.com/android/android-sdk_r${version}-macosx.zip"
      $installdir_real = $installdir ? { 'UNSET' => '/Developer/android', default => $installdir }
      $sdk_home = "${installdir_real}/android-sdk-mac_x86"
      $archive = "${installdir_real}/android-sdk_r${version}-macosx.zip"
    }
    default: {
      fail("Unsupported Kernel: ${::kernel} operatingsystem: ${::operatingsystem}")
    }
  }
  file { $installdir_real:
    ensure => directory,
    owner  => $android::user_real,
    group  => $android::group_real,
  }

}