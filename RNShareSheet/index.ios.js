'use strict';
import React, {
  AppRegistry,
  Component,
  StyleSheet,
  Text,
  TouchableOpacity,
  View
} from 'react-native';

import { ShareSheet } from 'NativeModules'

const share = {
  //imageUrl: 'http://facebook.github.io/react-native/img/opengraph.png',
  url: 'http://facebook.github.io/react-native/',
  text: 'React Native is Awesome!'
};
class ShareSheetDemo extends Component {
  render() {
    return (
      <View style={styles.container}>
        <TouchableOpacity onPress={() => ShareSheet.open(share)}>
          <Text style={styles.text}>
            Share
          </Text>
        </TouchableOpacity>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  text: {
    backgroundColor: 'lightblue',
    padding: 10,
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
});

AppRegistry.registerComponent('RNShareSheet', () => ShareSheetDemo);
