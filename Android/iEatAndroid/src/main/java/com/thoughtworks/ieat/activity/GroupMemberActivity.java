package com.thoughtworks.ieat.activity;

import android.app.Activity;
import android.os.Bundle;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.R;

public class GroupMemberActivity extends Activity {

    private Object group;

    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.group_member);

        group = getIntent().getExtras().get(IEatApplication.EXTRA_GROUP);


    }

}
