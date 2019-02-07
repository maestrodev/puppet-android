# == Class: android::params
#
# Defines some sensible default parameters.
#
# === Authors
#
# Etienne Pelletier <epelletier@maestrodev.com>
#
# === Copyright
#
# Copyright 2012 MaestroDev, unless otherwise noted.
#
class android::params {

  $version    = '4333796'
  $proxy_host = undef
  $proxy_port = undef
  $installdir = '/usr/local/android'

  $ndk_version = 'r18b'

  case $::kernel {
    'Linux': {
      $user       = 'root'
      $group      = 'root'
    }
    'Darwin': {
      $user       = 'root'
      $group      = 'admin'
    }
    default: {
      fail("Unsupported Kernel: ${::kernel} operatingsystem: ${::operatingsystem}")
    }
  }
}
