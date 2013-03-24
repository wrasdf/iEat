package com.thoughtworks.ieat.activity;

import android.app.LocalActivityManager;
import android.app.TabActivity;
import android.content.Intent;
import android.content.res.Resources;
import android.os.Bundle;
import android.widget.TabHost;
import com.thoughtworks.ieat.R;

public class GroupTabActivity extends TabActivity {

    private LocalActivityManager mlam;

    @Override
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);

        setContentView(R.layout.group_tab_main);
        Resources res = getResources();
        TabHost tabHost = getTabHost();
        TabHost.TabSpec spec;
        Intent intent;

        intent = new Intent().setClass(this, GroupInfoActivity.class);
        intent.putExtras(getIntent());
        spec = tabHost.newTabSpec(res.getString(R.string.group_info_tab_label)).setIndicator(res.getString(R.string.group_info_tab_label)).setContent(intent);
        tabHost.addTab(spec);

        intent = new Intent().setClass(this, GroupAnalysisActivity.class);
        intent.putExtras(getIntent());
        spec = tabHost.newTabSpec(res.getString(R.string.group_analysis_tab_label)).setIndicator(res.getString(R.string.group_analysis_tab_label)).setContent(intent);
        tabHost.addTab(spec);
    }

}
