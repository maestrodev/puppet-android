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
  $version    = $android::version

  case $::kernel {
    'Linux': {
      $sdk_home     = "${installdir}/android-sdk-linux"
      $distrib_file = "android-sdk_r${version}-linux.tgz"
    }
    'Darwin': {
      $sdk_home     = "${installdir}/android-sdk-macosx"
      $distrib_file = "android-sdk_r${version}-macosx.zip"
    }
    default: {
      fail("Unsupported Kernel: ${::kernel} operatingsystem: ${::operatingsystem}")
    }
  }
  $source   = "http://dl.google.com/android/${distrib_file}"
  $archive  = "${installdir}/${distrib_file}"

  $toolsdir = "${sdk_home}/tools"
}
