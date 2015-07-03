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

  android::package{ 'tool':
    type => 'tool',
  }

}
