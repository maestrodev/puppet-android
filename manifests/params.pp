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

  $version = '20.0.3'
  $proxy_host = undef
  $proxy_port = undef
  
  case $::kernel {
    'Linux': {
      $user = 'root'
      $group = 'root'
      $installdir = '/usr/local/android'
    }
    'Darwin': {
      $user = 'root'
      $group = 'admin'
      $installdir = '/Developer/android'
    }
    default: {
      fail("Unsupported Kernel: ${::kernel} operatingsystem: ${::operatingsystem}")
    }
  }
}