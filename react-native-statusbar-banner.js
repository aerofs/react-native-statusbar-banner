/**
 * Created by Rahul Jiresal on 01/22/16.
 */

'use strict';

var React = require('react-native');
var RNSBNative = React.NativeModules.StatusBarNotificationBanner;

type Props = {
  isVisible: boolean;
}

module.exports = {
  show: function(message, color) {
  	RNSBNative.showNotificationWithMessage(message, color);
  },

  hide: function() {
  	RNSBNative.hideNotificationBanner();
  }
};