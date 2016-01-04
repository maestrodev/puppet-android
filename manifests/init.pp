# == Class: android
#
# This class is used to install the Android SDK and platform tools.
#
# === Examples
#
# To install the Android SDK:
#   class { 'java': } ->
#   class { 'android':
#     user       => 'someuser',
#     group      => 'somegroup',
#     installdir => '/path/to/your/dir',
#   }
#
# === Parameters
#
# [*version*] The SDK version
# [*user*] Used to set the file ownership of the installed SDK
# [*group*] Used to set the file ownership of the installed SDK
# [*installdir*] The install directory
# [*proxy_host*] The proxy server host name (used by the 'android' tool)
# [*proxy_port*] The proxy server port (used by the 'android' tool)
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
  $installdir = $android::params::installdir,
  $proxy_host = $android::params::proxy_host,
  $proxy_port = $android::params::proxy_port,
) inherits android::params {

  validate_re($version, '^\d+(?:\.\d+)*$', "Invalid version: ${version}")
  validate_string($user)
  validate_string($group)
  validate_absolute_path($installdir)

  if ($proxy_host != undef) {
    validate_string($proxy_host, '^\d+$')
  }

  if ($proxy_port != undef) {
    validate_re($proxy_port, '^\d+$', "Invalid proxy port: ${proxy_port}")
  }

  anchor { 'android::begin': } ->
  class { 'android::paths': } ->
  class { 'android::sdk': } ->
  class { 'android::platform_tools': } ->
  anchor { 'android::end': }
}
