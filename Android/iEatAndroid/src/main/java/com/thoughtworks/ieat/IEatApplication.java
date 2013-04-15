package com.thoughtworks.ieat;

import android.app.Activity;
import android.app.Application;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import com.thoughtworks.ieat.domain.User;
import com.thoughtworks.ieat.utils.ApplicationData;
import com.thoughtworks.ieat.utils.PropertyUtils;

import java.util.LinkedList;
import java.util.List;

public class IEatApplication extends Application {

    public static final String DATE_PATTERN = "yyyy-MM-dd'T'HH:mm:ssz";
    public static final String DATE_DISPLAY_PATTERN = "yyyy-MM-dd HH:mm:ss";
    private static String currentUserName;

    public static String token;
    public static final String EXTRA_GROUP_ID = "EXTRA_GROUP_ID";
    public static final String EXTRA_GROUP = "EXTRA_GROUP";
    public static final String EXTRA_TAG = "EXTRA_TAG";
    public static final String EXTRA_ORDER_LIST = "EXTRA_ORDER_LIST";
    public static final String EXTRA_BILL = "EXTRA_BILL";

    private static List<Activity> activeActivity = new LinkedList<Activity>();

    @Override
    public void onCreate() {
        PropertyUtils.init(getResources());
        SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(getApplicationContext());
        ApplicationData.init(prefs);
    }

    public static void login(String username, String token) {
        ApplicationData.setUsername(username);
        ApplicationData.setUserToken(token);
        currentUserName = username;
        IEatApplication.token = token;
    }

    public void logout() {
        currentUserName = null;
        token = null;
        ApplicationData.setUsername(null);
        ApplicationData.setUserToken(null);
    }

    public static String currentUser() {
        if (currentUserName == null) {
            currentUserName = ApplicationData.getCurrentUser();
        }
        return currentUserName;
    }

    public static String getToken() {
        if (token == null) {
            token = ApplicationData.getToken();
        }
        return token;
    }

    public static void addActivity(Activity activity) {
        activeActivity.add(activity);
    }

    public static void exit() {
        for (Activity activity : activeActivity) {
            activity.finish();
        }
        System.exit(0);
    }

}
