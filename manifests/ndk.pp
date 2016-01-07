# == Class: android::ndk
#
# This downloads and unpacks the Android NDK from Google's download
# sever, or another specified server.
#
# Note that the NDK is expected to be a self extracting, so the
# older .tar.gz packages that are simply extracted will not be supported.
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
  $ndk_version = $android::params::ndk_version
)
{
  include android
  include wget

  $base_path = "http://dl.google.com/android/ndk/${ndk_version}"
  $ndk_installer = "${android::paths::installdir}/${ndk_version}"
  wget::fetch { 'download-androidndk':
    source      => $base_path,
    destination => $ndk_installer,
  } ->
  file { 'android-ndkexecutable':
    ensure => present,
    path   => $ndk_installer,
    owner  => $android::user,
    group  => $android::group,
    mode   => '0755',
  } ->
  exec { 'run-androidndk':
    command => "${ndk_installer} -y",
    cwd     => $android::paths::installdir,
  }

}
