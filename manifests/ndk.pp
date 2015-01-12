class android::ndk(
  $ndk_version = $android::params::ndk_version
) inherits android::params {

  include wget

  $base_path = "http://dl.google.com/android/ndk/${ndk_version}"
  $ndk_installer = "${android::paths::installdir}/${ndk_version}"
  wget::fetch { 'download-androidndk':
    source => $base_path,
    destination => $ndk_installer
  } ->
  file { 'android-ndkexecutable':
    ensure => present,
    path => $ndk_installer,
    owner  => $android::user,
    group  => $android::group,
    mode => '0755'
  } ->
  exec { 'run-androidndk':
    command => $ndk_installer,
    cwd => $android::params::installdir,
  }

}

