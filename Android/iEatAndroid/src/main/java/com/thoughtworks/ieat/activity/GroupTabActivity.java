package com.thoughtworks.ieat.activity;

import android.app.Activity;
import android.app.LocalActivityManager;
import android.app.ProgressDialog;
import android.content.Intent;
import android.content.res.Resources;
import android.os.AsyncTask;
import android.os.Bundle;
import android.widget.TabHost;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.domain.AppHttpResponse;
import com.thoughtworks.ieat.domain.Group;
import com.thoughtworks.ieat.utils.HttpUtils;

public class GroupTabActivity extends Activity {

    private LocalActivityManager mlam;

    @Override
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.group_info);

        setContentView(R.layout.group_tab_main);
        Resources res = getResources();
        mlam = new LocalActivityManager(this, false);
        mlam.dispatchCreate(bundle);
        TabHost tabHost = (TabHost) findViewById(R.id.group_tab);
        tabHost.setup(mlam);
        TabHost.TabSpec spec;
        Intent intent;

        intent = new Intent().setClass(this, GroupInfoActivity.class);
        spec = tabHost.newTabSpec(res.getString(R.string.group_info_tab_label)).setContent(intent);
        tabHost.addTab(spec);

        intent = new Intent().setClass(this, GroupAnalysisActivity.class);
        spec = tabHost.newTabSpec(res.getString(R.string.group_analysis_tab_label)).setContent(intent);
        tabHost.addTab(spec);
    }

    @Override
    public void onResume() {
        super.onResume();

        mlam.dispatchResume();
    }

    public void onPause() {
        super.onPause();
        mlam.dispatchPause(isFinishing());
    }


}
