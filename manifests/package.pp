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
define android::package($type) {
  include android

  $proxy_host = $android::proxy_host ? { undef => '', default => "--proxy-host ${android::proxy_host}" }
  $proxy_port = $android::proxy_port ? { undef => '', default => "--proxy-port ${android::proxy_port}" }

  case $type {
    'platform-tools': {
      $creates = "${android::paths::sdk_home}/platform-tools"
    }
    'platform': {
      $creates = "${android::paths::sdk_home}/platforms/${title}"
    }
    'system-images': {
      $title_parts = split($title, '-')
      $creates = "${android::paths::sdk_home}/system-images/android-${title_parts[1]}"
    }
    'addon': {
      $creates = "${android::paths::sdk_home}/add-ons/${title}"
    }
    'extra': {
      $title_parts = split($title, '-')
      $creates = "${android::paths::sdk_home}/extras/${title_parts[1]}/${title_parts[2]}"
    }
    'build-tools': {
      $title_parts = split($title, '-')
      
      $creates = "${android::paths::sdk_home}/build-tools/${title_parts[2]}"
    }
    default: {
      fail("Unsupported package type: ${type}")
    }
  }

  case $::kernel {
    'Darwin': {}
    default: {
      ensure_packages(['expect'])
      Package['expect'] -> Exec["update-android-package-${title}"]
    }
  }

  file { "${android::installdir}/expect-install-${title}":
    content => template("android/expect-script.erb"),
  } ->
  exec { "update-android-package-${title}":
    command => "/usr/bin/expect -f ${android::installdir}/expect-install-${title}",
    creates => $creates,
    timeout => 0,
    require => [Class['Android::Sdk']],
  }


}
