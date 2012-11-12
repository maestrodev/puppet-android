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
class android($version = '20.0.3', $user = 'UNSET', $group = 'UNSET', $installdir = 'UNSET') {

  $user_real = $user ? { 'UNSET' => 'root', default => $user }
  $group_real = $group ? { 'UNSET' => 'root', default => $group }

  include android::paths
  include android::sdk
  include android::platform_tools
}