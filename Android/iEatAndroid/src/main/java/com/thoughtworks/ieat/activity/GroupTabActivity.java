package com.thoughtworks.ieat.activity;

import android.app.LocalActivityManager;
import android.app.ProgressDialog;
import android.app.TabActivity;
import android.content.Intent;
import android.content.res.Resources;
import android.os.AsyncTask;
import android.os.Bundle;
import android.widget.TabHost;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.domain.AppHttpResponse;
import com.thoughtworks.ieat.domain.Group;
import com.thoughtworks.ieat.service.Server;

public class GroupTabActivity extends TabActivity {

    private Group group;

    @Override
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);

        setContentView(R.layout.group_tab_main);
        group = (Group) getIntent().getExtras().get(IEatApplication.EXTRA_GROUP);

        setTabs(group);
    }

    private void setTabs(Group group) {
        Resources res = getResources();
        TabHost tabHost = getTabHost();
        TabHost.TabSpec spec;
        Intent intent;

        intent = new Intent().setClass(this, GroupInfoActivity.class);
        intent.putExtra(IEatApplication.EXTRA_GROUP, group);
        spec = tabHost.newTabSpec(res.getString(R.string.group_info_tab_label)).setIndicator(res.getString(R.string.group_info_tab_label)).setContent(intent);
        tabHost.addTab(spec);

        intent = new Intent().setClass(this, GroupAnalysisActivity.class);
        intent.putExtra(IEatApplication.EXTRA_GROUP, group);
        spec = tabHost.newTabSpec(res.getString(R.string.group_analysis_tab_label)).setIndicator(res.getString(R.string.group_analysis_tab_label)).setContent(intent);
        tabHost.addTab(spec);

        intent = new Intent().setClass(this, GroupMyselfActivity.class);
        intent.putExtra(IEatApplication.EXTRA_GROUP, group);
        spec = tabHost.newTabSpec(res.getString(R.string.group_myself_tab_label)).setIndicator(res.getString(R.string.group_myself_tab_label)).setContent(intent);
        tabHost.addTab(spec);

        intent = new Intent().setClass(this, GroupMemberActivity.class);
        intent.putExtra(IEatApplication.EXTRA_GROUP, group);
        spec = tabHost.newTabSpec(res.getString(R.string.group_member_tab_label)).setIndicator(res.getString(R.string.group_member_tab_label)).setContent(intent);
        tabHost.addTab(spec);
    }
}
