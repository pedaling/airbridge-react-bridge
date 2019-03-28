import {
    NativeModules
} from 'react-native';
import React from 'react';

NativeModules.AirbridgeBridge = {
    init: jest.fn(),
    setEmail: jest.fn(),
    setUser: jest.fn(),
    goal: jest.fn(),
    signIn: jest.fn(),
    signUp: jest.fn(),
    sendViewHome: jest.fn(),
    sendViewProductList: jest.fn(),
    sendViewSearchResult: jest.fn(),
    sendViewProductDetail: jest.fn(),
    sendAddToCart: jest.fn(),
    sendCompleteOrder: jest.fn(),
    expireUser: jest.fn(),
    setCustomSessionTimeOut: jest.fn(),
    setWifiInfoUsability: jest.fn(),
    deeplinkLaunched: jest.fn(),
};

const AirbridgeApi = require('react-native-airbridge-bridge');

test('Init airbridge api', () => {
    testName = 'TEST_APP_NAME';
    testToken = 'TEST_APP_TOKEN';

    AirbridgeApi.init(testName, testToken)
    expect(NativeModules.AirbridgeBridge.init.mock.calls.length).toBe(1);
    expect(NativeModules.AirbridgeBridge.init.mock.calls[0][0]).toBe(testName);
    expect(NativeModules.AirbridgeBridge.init.mock.calls[0][1]).toBe(testToken);
});

test('setEmail api', () => {
    testEmail = 'email@ab180.co';
    AirbridgeApi.setEmail(testEmail);
    expect(NativeModules.AirbridgeBridge.setEmail.mock.calls.length).toBe(1);
    expect(NativeModules.AirbridgeBridge.setEmail.mock.calls[0][0]).toBe(testEmail);
});

test('setUser api', () => {
    testUser = 'donutt';
    AirbridgeApi.setUser(testUser);
    expect(NativeModules.AirbridgeBridge.setUser.mock.calls.length).toBe(1);
    expect(NativeModules.AirbridgeBridge.setUser.mock.calls[0][0]).toBe(testUser);
});

test('goal api', () => {
    testCategory = 'TEST_CATEGORY';
    testAction = 'TEST_ACTION';
    testLabel = 'TEST_LABEL';
    testValue = 0;
    testCustomAttributes = {'customAttr1': '1'};

    AirbridgeApi.goal(testCategory, testAction, testLabel, testValue, testCustomAttributes);
    expect(NativeModules.AirbridgeBridge.goal.mock.calls.length).toBe(1);
    expect(NativeModules.AirbridgeBridge.goal.mock.calls[0][0]).toBe(testCategory);
    expect(NativeModules.AirbridgeBridge.goal.mock.calls[0][1]).toBe(testAction);
    expect(NativeModules.AirbridgeBridge.goal.mock.calls[0][2]).toBe(testLabel);
    expect(NativeModules.AirbridgeBridge.goal.mock.calls[0][3]).toBe(testValue);
    expect(NativeModules.AirbridgeBridge.goal.mock.calls[0][4]).toBe(testCustomAttributes);
});

test('signIn api', () => {
    testUserObj = AirbridgeApi.makeUserObject({'userId': 'donutt', 'userEmail': 'email@ab180.co'})
    AirbridgeApi.signIn(testUserObj);
    expect(NativeModules.AirbridgeBridge.signIn.mock.calls.length).toBe(1);
    expect(NativeModules.AirbridgeBridge.signIn.mock.calls[0][0]).toBe(testUserObj);
});

test('signUp api', () => {
    testUserObj = AirbridgeApi.makeUserObject({'userId': 'donutt', 'userEmail': 'email@ab180.co'})
    AirbridgeApi.signUp(testUserObj);
    expect(NativeModules.AirbridgeBridge.signUp.mock.calls.length).toBe(1);
    expect(NativeModules.AirbridgeBridge.signUp.mock.calls[0][0]).toBe(testUserObj);
});

test('sendViewHome api', () => {
    AirbridgeApi.sendViewHome();
    expect(NativeModules.AirbridgeBridge.signUp.mock.calls.length).toBe(1);
});

test('sendViewProductList api', () => {
    testListID = '1';
    testProducts = [AirbridgeApi.makeProduct({productId: '1', price: 100}), AirbridgeApi.makeProduct({productId: '2', quantity: 3})];
    AirbridgeApi.sendViewProductList(testListID, testProducts);
    expect(NativeModules.AirbridgeBridge.sendViewProductList.mock.calls.length).toBe(1);
    expect(NativeModules.AirbridgeBridge.sendViewProductList.mock.calls[0][0]).toBe(testListID);
    expect(NativeModules.AirbridgeBridge.sendViewProductList.mock.calls[0][1]).toBe(testProducts);
});

test('sendViewSearchResults api', () => {
    testQuery = 'search test';
    testProducts = [AirbridgeApi.makeProduct({productId: '1', price: 100}), AirbridgeApi.makeProduct({productId: '2', quantity: 3})];
    AirbridgeApi.sendViewSearchResult(testQuery, testProducts);
    expect(NativeModules.AirbridgeBridge.sendViewSearchResult.mock.calls.length).toBe(1);
    expect(NativeModules.AirbridgeBridge.sendViewSearchResult.mock.calls[0][0]).toBe(testQuery);
    expect(NativeModules.AirbridgeBridge.sendViewSearchResult.mock.calls[0][1]).toBe(testProducts);
});

test('sendViewProductDetail api', () => {
    testProduct = AirbridgeApi.makeProduct({productId: '1', price: 100});
    AirbridgeApi.sendViewProductDetail(testProduct);
    expect(NativeModules.AirbridgeBridge.sendViewProductDetail.mock.calls.length).toBe(1);
    expect(NativeModules.AirbridgeBridge.sendViewProductDetail.mock.calls[0][0]).toBe(testProduct);
});

test('sendAddToCart api', () => {
    testProduct = AirbridgeApi.makeProduct({productId: '1', price: 100});
    testCartID = 'cartID1';
    testCurrency = 'KRW';
    testTotalValue = 0;
    AirbridgeApi.sendAddToCart(testProduct, testCartID);
    expect(NativeModules.AirbridgeBridge.sendAddToCart.mock.calls.length).toBe(1);
    expect(NativeModules.AirbridgeBridge.sendAddToCart.mock.calls[0][0]).toBe(testProduct);
    expect(NativeModules.AirbridgeBridge.sendAddToCart.mock.calls[0][1]).toBe(testCartID);
    expect(NativeModules.AirbridgeBridge.sendAddToCart.mock.calls[0][2]).toBe(testCurrency);
    expect(NativeModules.AirbridgeBridge.sendAddToCart.mock.calls[0][3]).toBe(testTotalValue);
});

test('sendCompleteOrder api', () => {
    testProducts = [AirbridgeApi.makeProduct({productId: '1', price: 100}), AirbridgeApi.makeProduct({productId: '2', quantity: 3})];
    testTransID = 'tr-1';
    testIsInAppPurchase = true;
    testCurrency = 'KRW';
    testTotalValue = 0;
    AirbridgeApi.sendCompleteOrder(testProducts, testTransID, testIsInAppPurchase);
    expect(NativeModules.AirbridgeBridge.sendCompleteOrder.mock.calls.length).toBe(1);
    expect(NativeModules.AirbridgeBridge.sendCompleteOrder.mock.calls[0][0]).toBe(testProducts);
    expect(NativeModules.AirbridgeBridge.sendCompleteOrder.mock.calls[0][1]).toBe(testTransID);
    expect(NativeModules.AirbridgeBridge.sendCompleteOrder.mock.calls[0][2]).toBe(testIsInAppPurchase);
    expect(NativeModules.AirbridgeBridge.sendCompleteOrder.mock.calls[0][3]).toBe(testCurrency);
    expect(NativeModules.AirbridgeBridge.sendCompleteOrder.mock.calls[0][4]).toBe(testTotalValue);
});

test('expireUser api', () => {
    AirbridgeApi.expireUser();
    expect(NativeModules.AirbridgeBridge.expireUser.mock.calls.length).toBe(1);
});

test('setCustomSessionTimeOut api', () => {
    testMillisec = 100
    AirbridgeApi.setCustomSessionTimeOut(testMillisec);
    expect(NativeModules.AirbridgeBridge.setCustomSessionTimeOut.mock.calls.length).toBe(1);
    expect(NativeModules.AirbridgeBridge.setCustomSessionTimeOut.mock.calls[0][0]).toBe(testMillisec);
});

test('setWifiInfoUsability api', () => {
    AirbridgeApi.setWifiInfoUsability(true);
    expect(NativeModules.AirbridgeBridge.setWifiInfoUsability.mock.calls.length).toBe(1);
    expect(NativeModules.AirbridgeBridge.setWifiInfoUsability.mock.calls[0][0]).toBe(true);
});

test('deeplink Launched api', () => {
    testURL = 'http://airbridge.io';
    AirbridgeApi.deeplinkLaunched(testURL);
    expect(NativeModules.AirbridgeBridge.deeplinkLaunched.mock.calls.length).toBe(1);
    expect(NativeModules.AirbridgeBridge.deeplinkLaunched.mock.calls[0][0]).toBe(testURL);
});
