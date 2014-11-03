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
# Aska Wu <askawu@gmail.com>
#
# === Copyright
#
# Copyright 2012 MaestroDev, unless otherwise noted.
#

define android::update($keyword) {
  include android

  if ( $::id == 'root' ) {
    Exec { user => $android::user }
  }

  $proxy_host = $android::proxy_host ? { undef => '', default => "--proxy-host ${android::proxy_host}" }
  $proxy_port = $android::proxy_port ? { undef => '', default => "--proxy-port ${android::proxy_port}" }

  file { "${android::installdir}/expect-install-${title}":
    content => template("android/expect-script.erb"),
    mode    => '0755',
  } ->
  exec { "update-android-package-tools":
    command => "${android::installdir}/expect-install-${title}",
    timeout => 0,
    onlyif  => "${android::paths::toolsdir}/android list sdk -u | grep '${keyword}'",
    require => [Class['android::sdk']],
  }

}

