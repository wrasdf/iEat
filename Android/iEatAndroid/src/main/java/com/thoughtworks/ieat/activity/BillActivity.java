package com.thoughtworks.ieat.activity;

import android.app.TabActivity;
import android.content.Intent;
import android.content.res.Resources;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.widget.TabHost;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.activity.asynctask.BillAsyncTask;
import com.thoughtworks.ieat.domain.MyBill;
import com.thoughtworks.ieat.view.actionbar.ActionBarHelper;

public class BillActivity extends TabActivity{
    final ActionBarHelper mActionBarHelper = ActionBarHelper.createInstance(this);
    private MyBill myBill;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mActionBarHelper.onCreate(savedInstanceState);
        setContentView(R.layout.my_bill);

        myBill = ((MyBill) getIntent().getExtras().get(IEatApplication.EXTRA_BILL));

        setTabs(myBill);
    }

    private void setTabs(MyBill myBill) {
        Resources resources = getResources();
        TabHost tabHost = getTabHost();


        Intent intent = new Intent(this, PayBackActivity.class);
        intent.putExtra(IEatApplication.EXTRA_ORDER_LIST, myBill.getPaybackOrders());
        TabHost.TabSpec tabSpec = tabHost.newTabSpec(resources.getString(R.string.bill_payback_label))
                .setIndicator(resources.getString(R.string.bill_payback_label))
                .setContent(intent);
        tabHost.addTab(tabSpec);

        intent = new Intent(this, UnpaidOrderActivity.class);
        intent.putExtra(IEatApplication.EXTRA_ORDER_LIST, myBill.getUnpaidOrders());
        tabSpec = tabHost.newTabSpec(resources.getString(R.string.bill_unpaid_label))
                .setIndicator(resources.getString(R.string.bill_unpaid_label))
                .setContent(intent);
        tabHost.addTab(tabSpec);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        boolean retValue = false;
        retValue |= mActionBarHelper.onCreateOptionsMenu(menu);
        retValue |= super.onCreateOptionsMenu(menu);

        getActionBarHelper().setDisplayHomeAsUpEnabled(true);
        setTitle(R.string.bill_title);
        return retValue;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.actionbar_home_button:
            case android.R.id.home:
                Intent intent = new Intent(this, GroupListActivity.class);
                startActivity(intent);
                finish();
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

    /**{@inheritDoc}*/
    @Override
    protected void onPostCreate(Bundle savedInstanceState) {
        super.onPostCreate(savedInstanceState);
        mActionBarHelper.onPostCreate(savedInstanceState);
    }

    /**{@inheritDoc}*/
    @Override
    public void onTitleChanged(CharSequence title, int color) {
        mActionBarHelper.onTitleChanged(title, color);
        super.onTitleChanged(title, color);
    }
}
