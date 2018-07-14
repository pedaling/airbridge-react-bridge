
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

    sendViewHome: function(o) {
        AirbridgeBridge.sendViewHome(o);
    },

    makeUserObject: function(action='', label='', userId='', userEmail='') {
        return {
            action: action,
            label: label,
            userId: userId,
            userEmail: userEmail
        }
    },

    makeProduct: function(productId='', name='', currency='', price=0, quantity=0, positionInList=0) {
        return {
            productId: productId,
            name: name,
            currency: currency,
            price: price,
            quantity: quantity,
            positionInList: positionInList
        }
    }
 // setUser(String userId)
 //
 // signIn(String action, String label, String userId, String userEmail)
 //
 //
 // signUp(String action, String label, String userId, String userEmail)
 //
 // sendViewHome()
 //
 // sendViewProductList()
 //
 // sendViewSearchResult()
 //
 // sendCompleteOrder()
 //
 // expireuser()
 //
 // goal(String category, String action, String label, int value)
 //
 // setCustomSessionTimeOut()
 //
 //
 // setWifiInfoUsability()
 //
 // handleURL()
};

module.exports = AirbridgeBridgeApis;
