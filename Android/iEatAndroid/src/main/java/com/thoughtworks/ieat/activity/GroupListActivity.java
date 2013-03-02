package com.thoughtworks.ieat.activity;

import android.app.Activity;
import android.app.ProgressDialog;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.Menu;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.Toast;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.activity.view.GroupItemView;
import com.thoughtworks.ieat.activity.view.GroupsAdapter;
import com.thoughtworks.ieat.domain.Group;
import com.thoughtworks.ieat.domain.GroupList;
import com.thoughtworks.ieat.utils.HttpUtils;
import com.thoughtworks.ieat.utils.IOUtils;
import de.akquinet.android.androlog.Log;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;

import java.io.IOException;
import java.util.List;

public class GroupListActivity extends Activity {

    private LinearLayout myGroupLayout;
    private ListView todayGroupLayout;

    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.group_list);
        myGroupLayout = (LinearLayout) findViewById(R.id.my_groups);
        todayGroupLayout = (ListView) findViewById(R.id.today_groups);

    }

    public void onResume() {
        super.onResume();

        new GroupListAsyncTask().execute();
    }

    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.group_list, menu);

        return true;
    }

    public class GroupListAsyncTask extends AsyncTask<Void, Void, HttpResponse> {

        private ProgressDialog progressBar;

        @Override
        public void onPreExecute() {
            progressBar = new ProgressDialog(GroupListActivity.this);
            progressBar.setMessage("loading group...");
            progressBar.setCanceledOnTouchOutside(false);
        }

        @Override
        protected HttpResponse doInBackground(Void... params) {
            try {
                return HttpUtils.getTodayGroup();
            } catch (RuntimeException e) {
                Log.e(this.getClass().getName(), e.getMessage(), e);
            }
            return null;
        }

        @Override
        protected void onPostExecute(HttpResponse response) {
            if (HttpStatus.SC_OK == response.getStatusLine().getStatusCode()) {
                try {
                    String json = IOUtils.toString(response.getEntity().getContent());
                    Gson gson = new GsonBuilder().setDateFormat(Group.DATE_PATTERN).create();
                    GroupList groupList = gson.fromJson(json, GroupList.class);
                    displayMyGroup(groupList.getMyGroups());
                    displayTodayGroup(groupList.getGroupList());
                } catch (IOException e) {
                    Toast.makeText(GroupListActivity.this, e.getMessage(), Toast.LENGTH_SHORT).show();
                }


            }
            progressBar.dismiss();
        }


    }

    private void displayMyGroup(List<Group> myGroups) {
        for (Group myGroup : myGroups) {
            GroupItemView groupItemView = new GroupItemView(getApplicationContext());
            groupItemView.addGroup(myGroup);
            myGroupLayout.addView(groupItemView);
        }
    }

    private void displayTodayGroup(List<Group> groupList) {
        todayGroupLayout.setAdapter(new GroupsAdapter(getApplicationContext(), groupList));
    }
}
