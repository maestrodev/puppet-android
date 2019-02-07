# == Class: android::sdk
#
# This downloads and unpacks the Android SDK. It also
# installs necessary 32bit libraries for 64bit Linux systems.
#
# === Authors
#
# Etienne Pelletier <epelletier@maestrodev.com>
#
# === Copyright
#
# Copyright 2012 MaestroDev, unless otherwise noted.
#
class android::sdk {
  include android::paths
  include wget

  if ( $::id == 'root' ) {
    Exec { user => $android::user }
  }

  $unpack_command = "/usr/bin/unzip -q -o ${android::paths::archive} && chmod -R a+rx ${android::paths::sdk_home}"

  file { $android::paths::installdir:
    ensure => directory,
    owner  => $android::user,
    group  => $android::group,
  } ->
  file { $android::paths::sdk_home:
    ensure => directory,
    owner  => $android::user,
    group  => $android::group,
  } ->
  wget::fetch { 'download-androidsdk':
    source      => $android::paths::source,
    destination => $android::paths::archive,
  } ->
  exec { 'unpack-androidsdk':
    command => $unpack_command,
    creates => $android::paths::toolsdir,
    cwd     => $android::paths::sdk_home,
  }->
  file { 'android-executable':
    ensure => present,
    path   => "${android::paths::toolsdir}/android",
    owner  => $android::user,
    group  => $android::group,
    mode   => '0755',
  }

  # For 64bit systems, we need to install some 32bit libraries for the SDK
  # to work.
  if ($::kernel == 'Linux') and ($::architecture == 'x86_64' or $::architecture == 'amd64') {
    if $::lsbdistcodename == 'jessie' or $::lsbdistcodename == 'stretch' or $::lsbdistrelease == 14.04 {
      ensure_packages(['libc6-i386', 'lib32stdc++6', 'lib32gcc1', 'lib32ncurses5', 'lib32z1'])
    } else {
      ensure_packages($::osfamily ? {
        # list 64-bit version and use latest for installation too so that the same version is applied to both
        'RedHat' => ['glibc.i686','zlib.i686','libstdc++.i686','zlib','libstdc++'],
        'Debian' => ['ia32-libs'],
        default  => [],
      })
    }
  }
}
