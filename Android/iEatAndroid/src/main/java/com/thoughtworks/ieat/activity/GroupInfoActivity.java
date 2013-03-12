package com.thoughtworks.ieat.activity;

import android.app.Activity;
import android.app.ProgressDialog;
import android.os.AsyncTask;
import android.os.Bundle;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.domain.AppHttpResponse;
import com.thoughtworks.ieat.domain.Group;
import com.thoughtworks.ieat.utils.HttpUtils;

public class GroupInfoActivity extends Activity {

    private int groupId;

    @Override
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.group_info);

        groupId = bundle.getInt("GROUP_ID");
    }

    @Override
    public void onResume() {
        new GroupAsyncTask().execute(groupId);
    }

    public class GroupAsyncTask extends AsyncTask<Integer, Void, AppHttpResponse<Group>> {

        private ProgressDialog progressDialog;

        @Override
        public void onPreExecute() {
            progressDialog = new ProgressDialog(GroupInfoActivity.this);
            progressDialog.setMessage("loading...");
            progressDialog.show();
        }

        @Override
        protected AppHttpResponse<Group> doInBackground(Integer... groupIds) {
            return HttpUtils.getGroup(groupIds[0]);
        }

        @Override
        protected void onPostExecute(AppHttpResponse<Group> response) {
            progressDialog.dismiss();
        }
    }
}
