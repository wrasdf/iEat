package com.thoughtworks.ieat.test;

import android.test.ActivityInstrumentationTestCase2;
import com.thoughtworks.ieat.activity.LoginActivity;

public class HelloAndroidActivityTest extends ActivityInstrumentationTestCase2<LoginActivity> {

    public HelloAndroidActivityTest() {
        super(LoginActivity.class);
    }

    public void testActivity() {
        LoginActivity activity = getActivity();
        assertNotNull(activity);
    }
}

