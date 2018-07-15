
import { NativeModules } from 'react-native';

const { AirbridgeBridge } = NativeModules;

var AirbridgeBridgeApis = {
    init: function(appName, appToken) {
        AirbridgeBridge.init(appName, appToken);
    },

    setEmail: function(userEmail) {
        AirbridgeBridge.setEmail(userEmail);
    },

    setUser: function(userId) {
        AirbridgeBridge.setUser(userId);
    },

    goal: function(category='', action='', label='', value=0) {
        AirbridgeBridge.goal(category, action, label, value);
    },

    signIn: function(userObj) {
        AirbridgeBridge.signIn(userObj);
    },

    signUp: function(userObj) {
        AirbridgeBridge.signUp(userObj);
    },

    sendViewHome: function() {
        AirbridgeBridge.sendViewHome();
    },

    sendViewProductList: function(listId='', products=[]) {
        AirbridgeBridge.sendViewProductList(listId, products);
    },

    sendViewSearchResult: function(query='', products=[]) {
        AirbridgeBridge.sendViewSearchResult(query, products);
    },

    sendViewProductDetail: function(product) {
        AirbridgeBridge.sendViewProductDetail(product);
    },

    sendAddToCart: function(product, cartId='', currency='KRW', totalValue=0) {
        AirbridgeBridge.sendAddToCart(product, cartId, currency, totalValue);
    },

    sendCompleteOrder: function(products, transactionId='', isInAppPurchase=false, currency='KRW', totalValue=0) {
        AirbridgeBridge.sendCompleteOrder(products, transactionId, isInAppPurchase, currency, totalValue);
    },

    expireUser: function() {
        AirbridgeBridge.expireUser();
    },


    setCustomSessionTimeOut: function(timeout_msecs=300) {
        AirbridgeBridge.setCustomSessionTimeOut(timeout_msecs);
    },

    deeplinkLaunched: function(uri) {
        AirbridgeBridge.deeplinkLaunched(uri);
    },
    /**
     * This function return user object which is used in some analytics functions such as signIn and signUp.
     * We wrapped basic object in order to support default parameters.
     *
     * @param {object} user
     * @user {
     *      @userId: The identifier who call some function in mobile.
     *      @userEmail: The identifier's email address.
     * }
     * @returns {{userId: string, userEmail: string}}
     */
    makeUserObject: function(user) {
        return {
            userId: user['userId'] ? user['userId'] : '',
            userEmail: user['userEmail'] ? user['userEmail'] : ''
        };
    },

    /**
     * This function return product object which is used in purchase analytics such as sendAddToCart, etc.
     *
     * @param product
     * @product {
     *      @productId: Product unique identifier. You need to input this value when use dsp product. (default '')
     *      @name: Product name. (default '')
     *      @currency: Product currency. (default 'KRW')
     *      @price: Product price. (default 0)
     *      @quantity: Purchased quantity. (default 0)
     *      @positionInList: Product position in list. (default 0)
     * }
     * @returns {{productId: string, name: string, currency: string, price: number, quantity: number, positionInList: number}}
     */
    makeProduct: function(product) {
        return {
            productId: product['productId'] ? product['productId'] : '',
            name: product['name'] ? product['name'] : '',
            currency: product['currency'] ? product['currency'] : 'KRW',
            price: product['price'] ? product['price'] : 0,
            quantity: product['quantity'] ? product['quantity'] : 0,
            positionInList: product['positionInList'] ? product['positionInList'] : 0
        };
    },
};

module.exports = AirbridgeBridgeApis;
