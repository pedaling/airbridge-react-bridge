/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {Component} from 'react';
import {AppState, Platform, StyleSheet, Text, View} from 'react-native';

const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' + 'Cmd+D or shake for dev menu',
  android:
    'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

type Props = {};

const AirbridgeApi = require('react-native-airbridge-bridge');

export default class App extends Component<Props> {

    constructor(props) {
      super(props);
      AirbridgeApi.init('38acf1efa9fc4f0987173f5a76516eb1', 'ablog');
      console.log('instructor');
      //ReactAirbridge.getInstance('38acf1efa9fc4f0987173f5a76516eb1','ablog');
        test = AirbridgeApi.getUserEvent(action='testAction', userId='testUserId');
        AirbridgeApi.sendViewHome(test);
    }

    state = {
        appState: AppState.currentState
    }

    componentDidMount() {
        AppState.addEventListener('change', this._handleAppStateChange);
    }

    componentWillUnmount() {
        AppState.removeEventListener('change', this._handleAppStateChange);
    }

    _handleAppStateChange = (nextAppState) => {
        if (this.state.appState.match(/inactive|background/) && nextAppState === 'active') {
            console.log('App has come to the foreground!')
        }
        console.log('State changed' + nextAppState);
        this.setState({appState: nextAppState});
    }

    render() {
        return (
            <Text>Current state is: {this.state.appState}</Text>
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

