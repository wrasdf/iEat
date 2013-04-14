package com.thoughtworks.ieat.activity.asynctask;

import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;
import com.thoughtworks.ieat.domain.AppHttpResponse;
import com.thoughtworks.ieat.domain.MyBill;
import com.thoughtworks.ieat.service.Server;

public class BillAsyncTask extends AsyncTask<Void, Void, AppHttpResponse<MyBill>> {
    private final Context context;
    private final PostProcessor<MyBill> processor;
    private ProgressDialog progressBar;

    public BillAsyncTask(PostProcessor<MyBill> processor, Context activity) {
        this.processor = processor;
        this.context = activity;
    }

    @Override
    protected void onPreExecute() {
        progressBar = new ProgressDialog(context);
        progressBar.setMessage("loading bills...");
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
            processor.process(myBillAppHttpResponse);
        }
    }
}
