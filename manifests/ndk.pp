# == Class: android::ndk
#
# This downloads and unpacks the Android NDK from Google's download
# server, or another specified server.
#
# Note that the NDK is expected to be a self extracting, so the older '.tar.gz'
# packages that are simply extracted will not be supported.
#
# === Examples
#
# To install the Android NDK r10c-linux-x86_64:
#   class { 'android::ndk':
#     ndk_version => 'android-ndk-r10c-linux-x86_64.bin'
#   }
#
# === Parameters
#
# [*ndk_version*] The NDK version and architecture to install
#
# === Authors
#
# Sam Kerr <kerr.sam@gmail.com>
#
# === Copyright
#
# Copyright 2015 Sam Kerr, unless otherwise noted.
#
class android::ndk(
  $ndk_version = $android::params::ndk_version,
) {

  validate_re($ndk_version, '\.bin$')

  include android::paths
  include android::params
  include wget

  if ( $::id == 'root' ) {
    Exec { user => $android::user }
  }

  $base_path = "http://dl.google.com/android/ndk/${ndk_version}"
  $ndk_installer = "${android::paths::installdir}/${ndk_version}"

  wget::fetch { 'download-androidndk':
    source      => $base_path,
    destination => $ndk_installer,
  } ->
  file { 'android-ndkexecutable':
    ensure => file,
    path   => $ndk_installer,
    owner  => $android::user,
    group  => $android::group,
    mode   => '0755',
  } ->
  exec { 'run-androidndk':
    command => "${ndk_installer} -y",
    creates => regsubst($ndk_installer, '^(.*)\.bin$','\1'),
    cwd     => $android::params::installdir,
  }
}
