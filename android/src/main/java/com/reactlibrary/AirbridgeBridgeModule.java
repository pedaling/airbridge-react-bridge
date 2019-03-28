
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

import android.app.Application;
import android.app.Application.ActivityLifecycleCallbacks;
import android.os.Bundle;
import android.app.Activity;
import android.util.Log;

import io.airbridge.*;
import io.airbridge.ecommerce.*;
import io.airbridge.statistics.events.*;
import io.airbridge.statistics.events.inapp.*;

public class AirbridgeBridgeModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;
    private static boolean isInit = false;

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
        if(isInit == true) {
            return;
        }

        Activity currentActivity = getCurrentActivity();

        AirBridge.setDebugMode(true);
        AirBridge.init(getReactApplicationContext(), appName, appToken);

        if(currentActivity != null) {
        	AirBridge.getLifecycleTracker().onActivityCreated(currentActivity, null);
    	} else {
            Application app = (Application) getReactApplicationContext().getApplicationContext();

            final ActivityLifecycleCallbacks callback = new ActivityLifecycleCallbacks() {
                @Override
                public void onActivityStarted(Activity activity) {
                    AirBridge.getLifecycleTracker().onActivityCreated(activity, null);

                    Application app = (Application) activity.getApplicationContext();
                    app.unregisterActivityLifecycleCallbacks(this);
                }

                @Override
                public void onActivityCreated(Activity activity, Bundle savedInstanceState) {}
                @Override
                public void onActivityResumed(Activity activity) {}
                @Override
                public void onActivityPaused(Activity activity) {}
                @Override
                public void onActivityStopped(Activity activity) {}
                @Override
                public void onActivitySaveInstanceState(Activity activity, Bundle outState) {}
                @Override
                public void onActivityDestroyed(Activity activity) {}
            };
            app.registerActivityLifecycleCallbacks(callback);
    	}

        isInit = true;
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
    public void goal(String category, String action, String label, int value, ReadableMap o) {
        GoalEvent event = new GoalEvent(category)
                .setAction(action)
                .setLabel(label)
                .setValue(value);

        HashMap _o = o.toHashMap();
        Iterator it = _o.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry pair = (Map.Entry)it.next();
            event.setCustomAttribute(pair.getKey().toString(), pair.getValue());
            it.remove();
        }

        AirBridge.getTracker().sendEvent(event);
    }

    @ReactMethod
    public void signIn(ReadableMap o) {
        SignInEvent event = new SignInEvent()
                .setUserId(o.getString("userId"))
                .setUserEmail(o.getString("userEmail"));

        AirBridge.getTracker().sendEvent(event);
    }

    @ReactMethod
    public void signUp(ReadableMap o) {
        SignUpEvent event = new SignUpEvent()
                .setUserId(o.getString("userId"))
                .setUserEmail(o.getString("userEmail"));

        AirBridge.getTracker().sendEvent(event);
    }

    @ReactMethod
    public void sendViewHome() {
        HomeViewEvent event = new HomeViewEvent();
        AirBridge.getTracker().sendEvent(event);
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
        }

        ProductListViewEvent event = new ProductListViewEvent(listId, products);
        AirBridge.getTracker().sendEvent(event);
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
        AirBridge.getTracker().sendEvent(event);
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
        AirBridge.getTracker().sendEvent(event);
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

        AirBridge.getTracker().sendEvent(event);
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

        AirBridge.getTracker().sendEvent(event);
    }

    @ReactMethod
    public void expireUser() {
        SignOutEvent event = new SignOutEvent();
        AirBridge.getTracker().sendEvent(event);
    }


    @ReactMethod
    public void setCustomSessionTimeOut(int timeout_msecs) {
        AirBridge.setCustomSessionTimeOut(timeout_msecs);
    }

    @ReactMethod
    public void setWifiInfoUsability(Boolean enabled) {
        AirBridge.setWifiInfoEnable(enabled);
    }

    @ReactMethod
    public void deeplinkLaunched(String uri) {
        AirBridge.getTracker().sendEvent(new DeepLinkLaunchEvent(uri));
    }
}