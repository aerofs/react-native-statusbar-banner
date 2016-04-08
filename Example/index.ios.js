/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */

import React, {
  AppRegistry,
  Component,
  StyleSheet,
  Text,
  View,
  TouchableOpacity
} from 'react-native';

let StatusbarBanner = require('react-native-statusbar-banner');

let RNStatusbarBanner = React.createClass({
  getInitialState: function() {
    return {
      showBanner: false
    }
  },

  render: function() {
    return (
      <View style={styles.container}>
        <TouchableOpacity onPress={this.pressed}>
          <Text style={styles.instructions}>
            Show/Hide
          </Text>
        </TouchableOpacity>
      </View>
    );
  },

  pressed: function(){
    if (this.state.showBanner) {
      StatusbarBanner.hide();
      this.setState({ showBanner: false });
    }
    else {
      StatusbarBanner.show("Hello", "#ff828c")
      this.setState({ showBanner: true });
    }
  }
});

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('RNStatusbarBanner', () => RNStatusbarBanner);
