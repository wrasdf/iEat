package com.thoughtworks.ieat;

import android.app.Application;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import com.thoughtworks.ieat.utils.ApplicationData;
import com.thoughtworks.ieat.utils.PropertyUtils;

public class IEatApplication extends Application {

    boolean isAuthenticated = false;

    @Override
    public void onCreate() {
        PropertyUtils.init(getResources());
        SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(getApplicationContext());
        ApplicationData.init(prefs);
    }

    public void login(String username) {
        isAuthenticated = true;
        ApplicationData.setUsername(username);
    }

    public void logout() {
        isAuthenticated = false;
    }
}
