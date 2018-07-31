/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {Component} from 'react';
import {AppState, Platform, StyleSheet, Text, View} from 'react-native';
import { Button } from 'react-native';


// import AirbridgeApi from 'react-native-airbridge-bridge';

const AirbridgeApi = require('react-native-airbridge-bridge');


const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' + 'Cmd+D or shake for dev menu',
  android:
    'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

type Props = {};

export default class App extends Component<Props> {

    constructor(props) {
      super(props);
      AirbridgeApi.init('ablog', '38acf1efa9fc4f0987173f5a76516eb1');

      console.log('instructor');
      //ReactAirbridge.getInstance('38acf1efa9fc4f0987173f5a76516eb1','ablog');
        // test = AirbridgeApi.makeUserObject(action='testAction', userId='testUserId');
        // AirbridgeApi.sendViewHome(test);
        // _l = [AirbridgeApi.makeProduct({productId: '1', price: 100}), AirbridgeApi.makeProduct({productId: '2', quantity: 3})];
        // AirbridgeApi.sendViewProductList('list-1', _l);
        // AirbridgeApi.sendViewProductDetail(AirbridgeApi.makeProduct({productId: "detail-1", currency: 'KRW', price: 100.5}));
    }

    state = {
        appState: AppState.currentState
    }

    setEmail() {
        AirbridgeApi.setEmail('airbridge@ab180.co');
    }

    setUser() {
        AirbridgeApi.setUser('UserAB');
    }

    goal() {
        AirbridgeApi.goal('category', 'action', 'label', 100,{'test':"ok"});
    }

    signIn() {
        _user = AirbridgeApi.makeUserObject({action: 'testAction', userId: 'UserAB',userEmail: 'test@a.com'});
        AirbridgeApi.signIn(_user);
    }

    signUp() {
        _user = AirbridgeApi.makeUserObject({action: 'testAction', userId: 'UserAB', userEmail: 'test@a.com'});
        AirbridgeApi.signUp(_user);
    }

    sendViewHome() {
        AirbridgeApi.sendViewHome();
    }

    sendViewProductList() {
        _l = [AirbridgeApi.makeProduct({productId: '1', price: 100}), AirbridgeApi.makeProduct({productId: '2', quantity: 3})];
        AirbridgeApi.sendViewProductList('ListID-123', _l);
    }

    sendViewSearchResult() {
        _l = [AirbridgeApi.makeProduct({productId: '1', price: 100}), AirbridgeApi.makeProduct({productId: '2', quantity: 3})];
        AirbridgeApi.sendViewSearchResult('Query-123', _l);
    }

    sendViewProductDetail() {
        AirbridgeApi.sendViewProductDetail(AirbridgeApi.makeProduct({productId: '1', currency: 'KRW', price: 100}));
    }

    sendAddToCart() {
        AirbridgeApi.sendAddToCart(AirbridgeApi.makeProduct({productId: '1', currency: 'KRW', price: 100}),
            cartId='Cart-123', currency='KRW', totalValue=10000);
    }

    sendCompleteOrder() {
        _l = [AirbridgeApi.makeProduct({productId: '1', price: 100}), AirbridgeApi.makeProduct({productId: '2', quantity: 3})];
        AirbridgeApi.sendCompleteOrder(_l, 'Transaction-123', true, 'KRW', 10000);
    }

    expireUser() {
        AirbridgeApi.expireUser();
    }

    setCustomSessionTimeOut() {
        AirbridgeApi.setCustomSessionTimeOut(100);
    }
    setWifiInfoUsability() {
        AirbridgeApi.setWifiInfoUsability(0);
    }

    deeplinkLaunched() {
        AirbridgeApi.deeplinkLaunched('http://deeplink?q=123');
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

    //test
    test1(){

      _user = AirbridgeApi.makeUserObject({action: 'testAction', userId: 'UserAB',userEmail: 'test@a.com'});
      var product1 = {productId: '1', price: 100 ,name:'airbloc', currency:'KRW',positionInList: 1, quantity: 2};
      var product2 = {productId: '2', quantity: 3};

      _productList = [AirbridgeApi.makeProduct(product1), AirbridgeApi.makeProduct(product2)];

      AirbridgeApi.init('ablog', '38acf1efa9fc4f0987173f5a76516eb1');
      AirbridgeApi.setEmail('airbridge@ab180.co');
      AirbridgeApi.setUser('UserAB');
      AirbridgeApi.goal('category', 'action', 'label', 100,{'test':"ok"});
      AirbridgeApi.signIn(_user);
      AirbridgeApi.signUp(_user);
      AirbridgeApi.sendViewHome();
      AirbridgeApi.sendViewProductList('ListID-123', _productList);
      AirbridgeApi.sendViewSearchResult('Query-123', _productList);
      AirbridgeApi.sendViewProductDetail(AirbridgeApi.makeProduct(product1));
      AirbridgeApi.sendAddToCart(AirbridgeApi.makeProduct(product1),
          cartId='Cart-123', currency='KRW', totalValue=10000);
      AirbridgeApi.sendCompleteOrder(_productList, 'Transaction-123', true, 'KRW', 10000);
      AirbridgeApi.expireUser();
      AirbridgeApi.setCustomSessionTimeOut(100);
      AirbridgeApi.setWifiInfoUsability(true);
      AirbridgeApi.deeplinkLaunched('http://deeplink?q=123');

    }

    render() {
        return (
            <View style={styles.container}>
                <Text>Current state is: {this.state.appState}</Text>
                <View style={styles.buttonContainer}>
                    <Button onPress={this.setEmail} title="Set email"/><View style={styles.buttonPad} />
                    <Button onPress={this.setUser} title="Set user"/><View style={styles.buttonPad} />
                    <Button onPress={this.goal} title="goal"/><View style={styles.buttonPad} />
                    <Button onPress={this.signIn} title="Sign in"/>
                </View>

                <View style={styles.buttonContainer}>
                    <Button onPress={this.signUp} title="Sign up"/><View style={styles.buttonPad} />
                    <Button onPress={this.sendViewHome} title="View home"/><View style={styles.buttonPad} />
                    <Button onPress={this.sendViewProductList} title="Product list"/>
                </View>

                <View style={styles.buttonContainer}>
                    <Button onPress={this.sendViewSearchResult} title="Search result"/><View style={styles.buttonPad} />
                    <Button onPress={this.sendViewProductDetail} title="Product detail"/><View style={styles.buttonPad} />
                    <Button onPress={this.sendAddToCart} title="Add to cart"/>
                </View>

                <View style={styles.buttonContainer}>
                    <Button onPress={this.sendCompleteOrder} title="Complete order"/><View style={styles.buttonPad} />
                    <Button onPress={this.expireUser} title="logout"/><View style={styles.buttonPad} />
                    <Button onPress={this.setCustomSessionTimeOut} title="Session timeout"/>
                </View>

                <View style={styles.buttonContainer}>
                    <Button onPress={this.setWifiInfoUsability} title="set WifiInfoUsability"/>
                    <Button onPress={this.deeplinkLaunched} title="deeplink"/>
                </View>
                <View style={styles.buttonContainer}>
                    <Button onPress={this.test1} title="test1"/>
                </View>
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
    buttonContainer: {
        margin: 10,
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
    },
    buttonPad: {
        width:20
    },
    alternativeLayoutButtonContainer: {
        margin: 20,
        flexDirection: 'row',
        justifyContent: 'space-between'
    }
});
