Puppet Module for Android SDK
=============================

[![Build Status](https://maestro.maestrodev.com/api/v1/projects/58/compositions/443/badge/icon)](https://maestro.maestrodev.com/projects/58/compositions/443)

This Puppet module is used to install the Android SDK, 
along with platforms and other add-ons.
You may need to install Java separately.

Supported platforms:

* Linux (RedHat, Debian families)
* Mac OS X

Examples
--------

To install the Android SDK in the default location (/usr/local/android on both Linux
and Mac OS X) you simply include the android class like so.

    class { 'java': } ->
    class { 'android': }

You can also change the default parameters like so:

```
  class { 'android':
    user       => 'someuser',
    group      => 'somegroup',
    installdir => '/path/to/your/dir',
  }
```

To install an android platform, do it like so:

```
  android::platform { 'android-16': }
```

You can also install add-ons:

```
  android::addon { 'addon-google_apis-google-16': }
```

Or extra's:

```
  android::extra { 'extra-google-play_billing': }
```

To install Android SDK Build-tools, revision 19.0.1

```
  android::build_tools { 'build-tools-19.0.1': }
```

Tip: to get the appropriate name of the add-ons/extras run the following command:

```
/usr/local/android/android-sdk-macosx/tools/android list sdk -u --all --extended|grep " or "
```

License
-------
```
  Copyright 2012-2014 MaestroDev

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
```
