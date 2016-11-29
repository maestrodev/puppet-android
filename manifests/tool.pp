# == Class: android::tools
#
# Installs the Android SDK Tools.
#
# === Authors
#
# Aska Wu <askawu@gmail.com>
#
# === Copyright
#
# Copyright 2012 MaestroDev, unless otherwise noted.

class android::tool {
  include android

  $title = "tool"

  if ( $::id == 'root' ) {
    Exec { user => $android::user }
  }

  $proxy_host = $android::proxy_host ? { undef => '', default => "--proxy-host ${android::proxy_host}" }
  $proxy_port = $android::proxy_port ? { undef => '', default => "--proxy-port ${android::proxy_port}" }

  file { "${android::installdir}/expect-install-tool":
    content => template("android/expect-script.erb"),
    mode    => '0755',
  } ->
  exec { "update-android-package-tools":
    command => "${android::installdir}/expect-install-tool",
    timeout => 0,
    onlyif  => "${android::paths::toolsdir}/android list sdk -u | grep 'Android SDK Tools, revision'",
    require => [Class['android::sdk']],
  }

}
