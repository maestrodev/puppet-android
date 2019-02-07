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

  if ( $::id == 'root' ) {
    Exec { user => $android::user }
  }

  $proxy_host = $android::proxy_host ? { undef => '', default => "--proxy-host ${android::proxy_host}" }
  $proxy_port = $android::proxy_port ? { undef => '', default => "--proxy-port ${android::proxy_port}" }
  $cleaned_title = regsubst($title, ';', '-', 'G')

  case $type {
    'platform-tools': {
      $create_path_suffix = 'platform-tools'
      $package_name = $title
    }
    'platform': {
      $create_path_suffix = "platforms/${title}"
      $package_name = "platforms;${title}"
    }
    'system-images': {
      $title_parts = split($title, ';')
      $create_path_suffix = "${type}/${title_parts[0]}/${title_parts[1]}/${title_parts[2]}"
      $package_name = "${type};${title}"
    }
    'addon': {
      $create_path_suffix = "add-ons/${title}"
      $package_name = "add-ons;${title}"
    }
    'extra': {
      $title_parts = split($title, ';')
      $create_path_suffix = join(['extras', join($title_parts, '/')], '/')
      $package_name = "extras;${title}"
    }
    'build-tools': {
      $create_path_suffix = "build-tools/${title}"
      $package_name = "${type};${title}"
    }
    default: {
      fail("Unsupported package type: ${type}")
    }
  }

  file { "${android::installdir}/expect-install-${cleaned_title}":
    content => template('android/expect-script.erb'),
    mode    => '0755',
  } ->
  exec { "update-android-package-${cleaned_title}":
    command => "${android::installdir}/expect-install-${cleaned_title}",
    creates => "${android::paths::sdk_home}/${create_path_suffix}",
    timeout => 0,
    require => [Class['android::sdk']],
  }

}
