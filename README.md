
# react-native-airbridge-bridge

## Getting started

`$ npm install react-native-airbridge-bridge --save`

### Mostly automatic installation

`$ react-native link react-native-airbridge-bridge`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-airbridge-bridge` and add `AirbridgeBridge.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libAirbridgeBridge.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.AirbridgeBridgePackage;` to the imports at the top of the file
  - Add `new AirbridgeBridgePackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-airbridge-bridge'
  	project(':react-native-airbridge-bridge').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-airbridge-bridge/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-airbridge-bridge')
  	```

## Usage
```javascript
import AirbridgeBridge from 'react-native-airbridge-bridge';

// TODO: What to do with the module?
AirbridgeBridge;
```
  