Puppet Module for Android SDK and NDK
=====================================

[![Build Status](https://maestro.maestrodev.com/api/v1/projects/58/compositions/443/badge/icon)](https://maestro.maestrodev.com/projects/58/compositions/443)

This Puppet module is used to install the Android SDK and NDK, along with
add-ons, build-tools, extras, platforms, and system images. You may need to
install Java separately.

Supported platforms:

* Linux (RedHat, Debian families)
* OS X (requires `wget` to be installed)

Examples
--------

To install the Android SDK and platform tools in the default location
(`/usr/local/android` on both Linux and OS X) you simply include the `android`
class like so:

```
class { 'java': } ->
class { 'android': }
```

You can also change the default parameters like so:

```
class { 'android':
  user       => 'someuser',
  group      => 'somegroup',
  installdir => '/path/to/your/dir',
}
```

You can install the Android NDK like so:

```
class { 'android::ndk':
  ndk_version => 'android-ndk-r10c-linux-x86_64.bin'
}
```

Note that the Android NDK is downloaded and executed, so only newer NDK
versions are supported. The older tar archives will not work properly.

To install an Android Platform, do it like so:

```
android::platform { 'android-16': }
```

You can also install add-ons:

```
android::addon { 'addon-google_apis-google-16': }
```

Or extras:

```
android::extra { 'extra-google-play_billing': }
```

Or system images:

```
android::system_images { 'sys-img-armeabi-v7a-android-23': }
```

To install the Android SDK Build-tools, revision 19.0.1:

```
android::build_tools { 'build-tools-19.0.1': }
```

For add-ons, extras, platforms, and system images, the revision number can be
specified using the optional `revision` parameter:

```
android::extra { 'extra-google-m2repository':
  revision => '24',
}
```

The add-on, extra, platform, or system image will only be upgraded only if the
installed revision is not equal to the specified revision. For build-tools, the
revision number forms part of the name of the build-tool, hence there is no
`revision` parameter.

The `revision` parameter can also take the value `present` that initially
installs the latest version of the add-on, extra, platform, or system image, but
does not upgrade it when a new version becomes available, and the value `latest`
that always upgrades the add-on, extra, platform, or system image to the latest
version:

```
android::extra { 'extra-android-m2repository':
  revision => latest,
}
```

Tip: To get the appropriate name of the add-on, extra, platform, or system
image, run the following command:

```
android list sdk --all --extended --no-ui | grep " or "
```

License
-------

```
Copyright 2012-2016 MaestroDev

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
