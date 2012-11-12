# == Define: android::package
#
# This defined resource is used to install Android SDK packages
#
# === Parameters
#
# [*type*] One of platform-tools, platform or addon. Indicates
# the type of package to install.
#
# === Authors
#
# Etienne Pelletier <epelletier@maestrodev.com>
#
# === Copyright
#
# Copyright 2012 MaestroDev, unless otherwise noted.
#
define android::package($type) {
  include android::paths

  case $type {
    'platform-tools': {
      $creates = "${android::paths::sdk_home}/platform-tools"
    }
    'platform': {
      $creates = "${android::paths::sdk_home}/platforms/${title}"
    }
    'addon': {
      $creates = "${android::paths::sdk_home}/add-ons/${title}"
    }
    default: {
      fail("Unsupported package type: ${type}")
    }


  }

  exec { "update-android-package-${title}":
    command => "${android::paths::sdk_home}/tools/android update sdk -u -t ${title}",
    creates => $creates,
    require => Class['android::sdk']
  }


}