package com.thoughtworks.ieat.activity;

import android.app.TabActivity;
import android.content.Context;
import android.content.Intent;
import android.content.res.Resources;
import android.os.Bundle;
import android.view.*;
import android.widget.TabHost;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.domain.Group;
import com.thoughtworks.ieat.view.actionbar.ActionBarHelper;

public class GroupTabActivity extends TabActivity{
    final ActionBarHelper mActionBarHelper = ActionBarHelper.createInstance(this);

    private Group group;
    private String actionSourceTag;

    @Override
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        mActionBarHelper.onCreate(bundle);
        setContentView(R.layout.group_tab_main);

        group = (Group) getIntent().getExtras().get(IEatApplication.EXTRA_GROUP);
        actionSourceTag = getIntent().getExtras().getString(IEatApplication.EXTRA_TAG);
        setTabs(group);
    }

    private void setTabs(Group group) {
        Resources res = getResources();
        TabHost tabHost = getTabHost();
        TabHost.TabSpec spec;
        Intent intent;

        intent = new Intent().setClass(this, GroupInfoActivity.class);
        intent.putExtra(IEatApplication.EXTRA_GROUP, group);
        spec = tabHost.newTabSpec(String.valueOf(R.string.group_info_tab_label)).setIndicator(res.getString(R.string.group_info_tab_label)).setContent(intent);
        tabHost.addTab(spec);

        intent = new Intent().setClass(this, GroupAnalysisActivity.class);
        intent.putExtra(IEatApplication.EXTRA_GROUP, group);
        spec = tabHost.newTabSpec(String.valueOf(R.string.group_analysis_tab_label)).setIndicator(res.getString(R.string.group_analysis_tab_label)).setContent(intent);
        tabHost.addTab(spec);

        intent = new Intent().setClass(this, GroupMyselfActivity.class);
        intent.putExtra(IEatApplication.EXTRA_GROUP, group);
        spec = tabHost.newTabSpec(String.valueOf(R.string.group_myself_tab_label)).setIndicator(res.getString(R.string.group_myself_tab_label)).setContent(intent);
        tabHost.addTab(spec);

        intent = new Intent().setClass(this, GroupMemberActivity.class);
        intent.putExtra(IEatApplication.EXTRA_GROUP, group);
        spec = tabHost.newTabSpec(String.valueOf(R.string.group_member_tab_label)).setIndicator(res.getString(R.string.group_member_tab_label)).setContent(intent);
        tabHost.addTab(spec);

        tabHost.setCurrentTabByTag(actionSourceTag);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        if (group.getDueDate().getTime() > System.currentTimeMillis()) {
            getMenuInflater().inflate(R.menu.group_info, menu);
        }
        boolean retValue = false;
        retValue |= mActionBarHelper.onCreateOptionsMenu(menu);
        retValue |= super.onCreateOptionsMenu(menu);

        getActionBarHelper().setDisplayHomeAsUpEnabled(true);
        setTitle(group.getName());
        return retValue;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.order_button:
                Intent intent = new Intent(this, OrderCreateActivity.class);
                intent.putExtra(IEatApplication.EXTRA_GROUP, group);
                startActivity(intent);
                break;
            case R.id.actionbar_home_button:
            case android.R.id.home:
                intent = new Intent(this, GroupListActivity.class);
                startActivity(intent);
                break;
        }
        return false;
    }

    protected ActionBarHelper getActionBarHelper() {
        return mActionBarHelper;
    }

    /**{@inheritDoc}*/
    @Override
    public MenuInflater getMenuInflater() {
        return mActionBarHelper.getMenuInflater(super.getMenuInflater());
    }

    @Override
    protected void onPostCreate(Bundle savedInstanceState) {
        super.onPostCreate(savedInstanceState);
        mActionBarHelper.onPostCreate(savedInstanceState);
    }

    @Override
    public void onTitleChanged(CharSequence title, int color) {
        mActionBarHelper.onTitleChanged(title, color);
        super.onTitleChanged(title, color);
    }


    public View createTabContent(String tag) {
        LayoutInflater inflater = (LayoutInflater) getSystemService(Context.LAYOUT_INFLATER_SERVICE);

        switch (Integer.valueOf(tag)) {
            case R.string.group_info_tab_label:
                return inflater.inflate(R.layout.group_info, null);
            case R.string.group_analysis_tab_label:
                return inflater.inflate(R.layout.group_analysis, null);
            case R.string.group_myself_tab_label:
                return inflater.inflate(R.layout.group_myself, null);
            case R.string.group_member_tab_label:
                return inflater.inflate(R.layout.group_member, null);
        }
        return null;
    }
}
