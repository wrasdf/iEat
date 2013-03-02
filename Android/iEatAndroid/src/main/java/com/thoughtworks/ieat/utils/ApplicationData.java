package com.thoughtworks.ieat.utils;

import android.content.SharedPreferences;

public class ApplicationData {
    private final static String KEY_CURRENT_USER_NAME = "CURRENT_USER_NAME";

    private static SharedPreferences sharedPreferences = null;

    public static void init(SharedPreferences preferences) {
        sharedPreferences = preferences;
    }

    public static void setUsername(String username) {
        try {
            SharedPreferences.Editor edit = sharedPreferences.edit();
            edit.putString(KEY_CURRENT_USER_NAME, username);
            edit.commit();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static String getCurrentUser() {
        return sharedPreferences.getString(KEY_CURRENT_USER_NAME, null);
    }
}
