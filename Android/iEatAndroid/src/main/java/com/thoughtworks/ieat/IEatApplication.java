package com.thoughtworks.ieat;

import android.app.Application;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import com.thoughtworks.ieat.domain.User;
import com.thoughtworks.ieat.utils.ApplicationData;
import com.thoughtworks.ieat.utils.PropertyUtils;

public class IEatApplication extends Application {

    public static final String DATE_PATTERN = "yyyy-MM-dd'T'HH:mm:ss'Z'";

    private static String currentUserName;
    public static String token;
    public static final String EXTRA_GROUP_ID = "EXTRA_GROUP_ID";

    @Override
    public void onCreate() {
        PropertyUtils.init(getResources());
        SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(getApplicationContext());
        ApplicationData.init(prefs);
    }

    public static void login(String username) {
        ApplicationData.setUsername(username);
        currentUserName = username;
    }

    public void logout() {
        currentUserName = null;

    }

    public static String currentUser() {
        if (currentUserName == null) {
            currentUserName = ApplicationData.getCurrentUser();
        }
        return currentUserName;
    }

}
