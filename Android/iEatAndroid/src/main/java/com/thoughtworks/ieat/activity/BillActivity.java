package com.thoughtworks.ieat.activity;

import android.app.ProgressDialog;
import android.app.TabActivity;
import android.content.Context;
import android.content.Intent;
import android.content.res.Resources;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.TabHost;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.domain.AppHttpResponse;
import com.thoughtworks.ieat.domain.MyBill;
import com.thoughtworks.ieat.service.Server;

public class BillActivity extends TabActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.my_bill);

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
    protected void onResume() {
        super.onResume();

        new BillAsyncTask(this).execute();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getActionBar().setDisplayHomeAsUpEnabled(true);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.actionbar_home_button:
            case android.R.id.home:
                Intent intent = new Intent(this, GroupListActivity.class);
                startActivity(intent);
                break;
        }
        return false;
    }

    private class BillAsyncTask extends AsyncTask<Void, Void, AppHttpResponse<MyBill>> {
        private final Context context;
        private ProgressDialog progressBar;

        public BillAsyncTask(Context activity) {
            this.context = activity;
        }

        @Override
        protected void onPreExecute() {
            progressBar = new ProgressDialog(context);
            progressBar.setMessage("loading group...");
            progressBar.setCanceledOnTouchOutside(false);
            progressBar.show();
        }

        @Override
        protected AppHttpResponse<MyBill> doInBackground(Void... params) {
            return Server.getMyBill();
        }

        @Override
        protected void onPostExecute(AppHttpResponse<MyBill> myBillAppHttpResponse) {
            progressBar.dismiss();
            if (myBillAppHttpResponse.isSuccessful()) {
                setTabs(myBillAppHttpResponse.getData());
            }
        }
    }
}
