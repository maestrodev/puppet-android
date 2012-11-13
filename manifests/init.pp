# == Class: android
#
# This class is used to install the android SDK and platform tools
#
# === Parameters:
#
# [*version*] the SDK version
# [*user*] used to set the file ownership of the installed SDK
# [*group*] used to set the file ownership of the installed SDK
# [*installdir*] the install directory.
#
# === Authors
#
# Etienne Pelletier <epelletier@maestrodev.com>
#
# === Copyright
#
# Copyright 2012 MaestroDev, unless otherwise noted.
#
class android(
  $version    = $android::params::version,
  $user       = $android::params::user,
  $group      = $android::params::group,
  $installdir = $android::params::installdir) inherits android::params {

  include android::paths
  include android::sdk
  include android::platform_tools
}