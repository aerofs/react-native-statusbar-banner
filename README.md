# react-native-statusbar-banner

[![License](https://img.shields.io/cocoapods/l/ReactNativeAutoUpdater.svg?style=flat)](https://spdx.org/licenses/MIT)
[![Platform](https://img.shields.io/cocoapods/p/ReactNativeAutoUpdater.svg?style=flat)](http://cocoapods.org/pods/ReactNativeAutoUpdater)

## About


## Installation

### iOS

1. `npm install react-native-statusbar-banner --save`
2. In the Xcode's "Project navigator", right click on your project's Libraries folder ➜ Add Files to _"Your Project Name"_
3. Go to `node_modules` ➜ `react-native-statusbar-banner` ➜ `iOS` ➜ select `ReactNativeStatusbarBanner.xcodeproj`
4. In the Xcode Project Navigator, click the root project, and in `General` tab, look for `Linked Frameworks and Libraries`. Click on the `+` button at the bottom and add `libReactNativeStatusbarBanner.a` from the list.

###Android

Coming soon.

## Usage

### iOS

```javascript
let StatusbarBanner = require('react-native-statusbar-banner');
StatusbarBanner.show("Hello", "#ff828c");
StatusbarBanner.hide();
```

### Android

Coming soon

## License

`react-native-statusbar-banner` is available under the MIT license. See the LICENSE file for more info.
