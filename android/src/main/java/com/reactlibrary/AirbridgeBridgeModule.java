
package com.reactlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.Callback;

import java.lang.Integer;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import android.app.Activity;
import android.util.Log;

import io.airbridge.*;

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
        AirBridge.init(this.reactContext, appName, appToken);
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
    public void signIn(String action, String label, String userId, String userEmail) {

    }

    @ReactMethod
    public void signUp(String action, String label, String userId, String userEmail) {

    }

    @ReactMethod
    public void sendViewHome(ReadableMap o) {
        Log.d("AirBridge", o.toHashMap().toString());
        Log.d("AirBridge", o.getString("a"));
    }

    @ReactMethod
    public void sendViewProductList() {

    }

    @ReactMethod
    public void sendViewSearchResult() {

    }

    @ReactMethod
    public void sendCompleteOrder() {

    }

    @ReactMethod
    public void expireuser() {

    }

    @ReactMethod
    public void goal(String category, String action, String label, int value) {

    }

    @ReactMethod
    public void setCustomSessionTimeOut() {

    }

    @ReactMethod
    public void setWifiInfoUsability() {

    }

    @ReactMethod
    public void handleURL() {

    }
}