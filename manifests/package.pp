# == Define: android::package
#
# This defined resource is used to install Android SDK packages
#
# === Parameters
#
# [*type*] One of platform-tools, platform, addon, extra or build-tools. Indicates
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
define android::package(
  $type,
  $revision = 'present',
) {

  include android

  if ( $::id == 'root' ) {
    Exec { user => $android::user }
  }

  $proxy_host = $android::proxy_host ? { undef => '', default => "--proxy-host ${android::proxy_host}" }
  $proxy_port = $android::proxy_port ? { undef => '', default => "--proxy-port ${android::proxy_port}" }

  case $type {
    'platform-tools': {
      $path = "${android::paths::sdk_home}/platform-tools"
    }
    'platform': {
      $path = "${android::paths::sdk_home}/platforms/${title}"
    }
    'system-images': {
      $title_parts = split($title, '-')
      $path = "${android::paths::sdk_home}/system-images/android-${title_parts[-1]}/default/${title_parts[2]}-${title_parts[3]}"
    }
    'addon': {
      $path = "${android::paths::sdk_home}/add-ons/${title}"
    }
    'extra': {
      $title_parts = split($title, '-')
      $path = "${android::paths::sdk_home}/extras/${title_parts[1]}/${title_parts[2]}"
    }
    'build-tools': {
      $title_parts = split($title, '-')
      $path = "${android::paths::sdk_home}/build-tools/${title_parts[2]}"
    }
    default: {
      fail("Unsupported package type: ${type}")
    }
  }

  case $revision {
    'latest': {
      $creates = undef
      $onlyif = "${android::paths::sdk_home}/tools/android list sdk --extended --no-ui ${proxy_host} ${proxy_port} | grep ${title}"
      $unless = undef
    }
    'present': {
      $creates = $path
      $onlyif = undef
      $unless = undef
    }
    /^\d+(?:\.\d+)*$/: {
      $creates = undef
      $onlyif = undef
      $unless = "grep 'Pkg.Revision=${revision}' ${path}/source.properties"
    }
    default: {
      fail("Invalid package revision: ${revision}")
    }
  }

  file { "${android::installdir}/expect-install-${title}":
    content => template('android/expect-script.erb'),
    mode    => '0755',
  } ->
  exec { "update-android-package-${title}":
    command => "${android::installdir}/expect-install-${title}",
    creates => $creates,
    onlyif  => $onlyif,
    path    => ['/bin', '/usr/bin'],  # For grep.
    timeout => 0,
    unless  => $unless,
    require => Class['android::sdk'],
  }
}
