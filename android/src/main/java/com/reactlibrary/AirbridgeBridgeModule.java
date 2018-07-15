
package com.reactlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.Callback;

import java.lang.Integer;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.Iterator;

import android.app.Activity;
import android.util.Log;

import io.airbridge.*;
import io.airbridge.ecommerce.*;
import io.airbridge.statistics.events.*;
import io.airbridge.statistics.events.inapp.*;

public class AirbridgeBridgeModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;

    public AirbridgeBridgeModule(ReactApplicationContext reactContext) {
      super(reactContext);
      this.reactContext = reactContext;
    }

    @Override
    public String getName() {
      return "AirbridgeBridge";
    }

    @ReactMethod
    public void init(String appName, String appToken) {
        Activity currentActivity = getCurrentActivity();

        AirBridge.setDebugMode(true);
        AirBridge.init(getReactApplicationContext(), appName, appToken);

        Log.d("AirBridge", AirBridge.getLifecycleTracker().toString());
        Log.d("AirBridge", currentActivity.toString());
        AirBridge.getLifecycleTracker().onActivityCreated(currentActivity, null);
    }

    @ReactMethod
    public void setEmail(String userEmail) {
        AirBridge.getTracker().setUserEmail(userEmail);
    }

    @ReactMethod
    public void setUser(String userId) {
        AirBridge.getTracker().setUserId(userId);
    }

    @ReactMethod
    public void goal(String category, String action, String label, int value) {
        GoalEvent event = new GoalEvent(category)
                .setAction(action)
                .setLabel(label)
                .setValue(value);

        AirBridge.getTracker().send(event);
    }

    @ReactMethod
    public void signIn(ReadableMap o) {
        SignInEvent event = new SignInEvent()
                .setUserId(o.getString("userId"))
                .setUserEmail(o.getString("userEmail"));

        AirBridge.getTracker().send(event);
    }

    @ReactMethod
    public void signUp(ReadableMap o) {
        SignUpEvent event = new SignUpEvent()
                .setUserId(o.getString("userId"))
                .setUserEmail(o.getString("userEmail"));

        AirBridge.getTracker().send(event);
    }

    @ReactMethod
    public void sendViewHome() {
        HomeViewEvent event = new HomeViewEvent();
        AirBridge.getTracker().send(event);
    }

    @ReactMethod
    public void sendViewProductList(String listId, ReadableArray rProductList) {
        ArrayList<Object> _l = rProductList.toArrayList();
        List<Product> products = new ArrayList<Product>();

        Iterator<Object> _iter = _l.iterator();
        while (_iter.hasNext()) {
            HashMap _o = ((HashMap)_iter.next());

            Product _p = new Product();
            _p.setProductId(_o.get("productId").toString());
            _p.setName(_o.get("name").toString());
            _p.setCurrency(_o.get("currency").toString());
            _p.setQuantity(((Double)_o.get("quantity")).intValue());
            _p.setPrice(((Double)_o.get("price")).floatValue());
            _p.setPositionInList(((Double)_o.get("positionInList")).intValue());
            products.add(_p);

            Log.d("AirBridge", _o.toString());
        }

        ProductListViewEvent event = new ProductListViewEvent(listId, products);
        AirBridge.getTracker().send(event);
    }

    @ReactMethod
    public void sendViewSearchResult(String query, ReadableArray rProductList) {
        ArrayList<Object> _l = rProductList.toArrayList();
        List<Product> products = new ArrayList<Product>();

        Iterator<Object> _iter = _l.iterator();
        while (_iter.hasNext()) {
            HashMap _o = ((HashMap)_iter.next());

            Product _p = new Product();
            _p.setProductId(_o.get("productId").toString());
            _p.setName(_o.get("name").toString());
            _p.setCurrency(_o.get("currency").toString());
            _p.setQuantity(((Double)_o.get("quantity")).intValue());
            _p.setPrice(((Double)_o.get("price")).floatValue());
            _p.setPositionInList(((Double)_o.get("positionInList")).intValue());
            products.add(_p);
        }
        SearchResultViewEvent event = new SearchResultViewEvent(query, products);
        AirBridge.getTracker().send(event);
    }

    @ReactMethod
    public void sendViewProductDetail(ReadableMap product) {
        Product _p = new Product();
        HashMap _o = product.toHashMap();
        _p.setProductId(_o.get("productId").toString());
        _p.setName(_o.get("name").toString());
        _p.setCurrency(_o.get("currency").toString());
        _p.setQuantity(((Double)_o.get("quantity")).intValue());
        _p.setPrice(((Double)_o.get("price")).floatValue());
        _p.setPositionInList(((Double)_o.get("positionInList")).intValue());

        ProductDetailsViewEvent event = new ProductDetailsViewEvent(_p);
        AirBridge.getTracker().send(event);
    }

    @ReactMethod
    public void sendAddToCart(ReadableMap product, String cartId, String currency, int totalValue) {
        Product _p = new Product();
        HashMap _o = product.toHashMap();
        _p.setProductId(_o.get("productId").toString());
        _p.setName(_o.get("name").toString());
        _p.setCurrency(_o.get("currency").toString());
        _p.setQuantity(((Double)_o.get("quantity")).intValue());
        _p.setPrice(((Double)_o.get("price")).floatValue());
        _p.setPositionInList(((Double)_o.get("positionInList")).intValue());

        AddedToCartEvent event = new AddedToCartEvent()
                .setCartId(cartId)
                .setCurrency(currency)
                .setTotalValue(totalValue)
                .addProduct(_p);

        AirBridge.getTracker().send(event);
    }

    @ReactMethod
    public void sendCompleteOrder(ReadableArray rProductList, String transactionId, boolean isInAppPurchase, String currency, int totalValue) {
        ArrayList<Object> _l = rProductList.toArrayList();
        List<Product> products = new ArrayList<Product>();

        Iterator<Object> _iter = _l.iterator();
        while (_iter.hasNext()) {
            HashMap _o = ((HashMap)_iter.next());

            Product _p = new Product();
            _p.setProductId(_o.get("productId").toString());
            _p.setName(_o.get("name").toString());
            _p.setCurrency(_o.get("currency").toString());
            _p.setQuantity(((Double)_o.get("quantity")).intValue());
            _p.setPrice(((Double)_o.get("price")).floatValue());
            _p.setPositionInList(((Double)_o.get("positionInList")).intValue());
            products.add(_p);
        }

        PurchaseEvent event = new PurchaseEvent(products)
                .setTransactionId(transactionId)
                .setInAppPurchased(isInAppPurchase)
                .setCurrency(currency)
                .setTotalValue(totalValue);

        AirBridge.getTracker().send(event);
    }

    @ReactMethod
    public void expireuser() {
        SignOutEvent event = new SignOutEvent();
        AirBridge.getTracker().send(event);
    }


    @ReactMethod
    public void setCustomSessionTimeOut(int timeout_msecs) {
        AirBridge.setCustomSessionTimeOut(timeout_msecs);
    }

    //    @ReactMethod
//    public void setWifiInfoUsability() {
//
//    }
//
    @ReactMethod
    public void deeplinkLaunched(String uri) {
        AirBridge.getTracker().send(new DeepLinkLaunchEvent(uri));
    }
}