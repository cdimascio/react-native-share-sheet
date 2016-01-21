# react-native-share-sheet

Use the iOS share sheet from React Native

##Install

1. `npm install react-native-share-sheet`
2. In XCode, in the project navigator, right click Libraries -> Add Files to  [YourProjectName]
3. Go to `node_modules/react-native-share-sheet/RNShareSheet` and add `RNShareSheet.m`, `RNShareSheet.swift, RNShareSheet-Bridging-Header.h`
4. Rename `RNShareSheet-Bridging-Header.h` to `[YourProjectName]-Bridging-Header.h`

##Use

`import { ShareSheet } from 'react-native-share-sheet`

```
const share = {
  imageUrl: 'http://facebook.github.io/react-native/img/opengraph.png',
  text: 'some super cool text'
}
ShareSheet.open(share)
```

##Example

```
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
  url: 'http://facebook.github.io/react-native/',
  text: 'some super cool text'
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

AppRegistry.registerComponent('ShareSheet', () => ShareSheetDemo);
```

##Options

| Property ||      Value	
|----------|---|:-------------:|
| text     | optional |  string |
| imageUrl | optional |  url string or asset library string |
| url      | optional |  url of the web page to share |

**If both `imageUrl` and `url` specified, `imageUrl` will appear as the share preview**

###Examples
####`imageUrl`
* Asset Library path 
	* `assets-library://asset/asset.JPG?id=FF5F38D6-AACC-1116-3091-AF3499CD923D&ext=JPG`
* Image Url
	* `http://facebook.github.io/react-native/img/opengraph.png`

####`text`
* \#ReactNative is awesome!

####`url`
* http://facebook.github.io/react-native/

##MISC

Works great with *react-native-camera*! 

Snap a pic with *react-native-camera* and share it with *react-native-share-sheet*. *react-native-camera* will return the new photo's asset library path which can be shared using *react-native-share-sheet*

##License
MIT