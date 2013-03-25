package com.thoughtworks.ieat.activity;

import android.app.Activity;
import android.app.ProgressDialog;
import android.os.AsyncTask;
import android.os.Bundle;
import android.widget.TextView;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.domain.AppHttpResponse;
import com.thoughtworks.ieat.domain.Group;
import com.thoughtworks.ieat.service.Server;

public class GroupInfoActivity extends Activity {


    private Group group;

    @Override
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.group_info);

        group = (Group) getIntent().getExtras().get(IEatApplication.EXTRA_GROUP);

        ((TextView) findViewById(R.id.group_info_name)).setText(group.getName());
        ((TextView) findViewById(R.id.group_info_owner_name)).setText(group.getOwner().getName());


        ((TextView) findViewById(R.id.group_info_restaurant_name)).setText(group.getRestaurant().getName());
        ((TextView) findViewById(R.id.group_info_restaurant_telephone)).setText(group.getRestaurant().getTelephone());
        ((TextView) findViewById(R.id.group_info_restaurant_address)).setText(group.getRestaurant().getAddress());
    }

    @Override
    public void onResume() {
        super.onResume();
    }


}
