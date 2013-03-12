package com.thoughtworks.ieat.activity;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.widget.AdapterView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.Toast;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.activity.view.GroupItemView;
import com.thoughtworks.ieat.activity.view.GroupsAdapter;
import com.thoughtworks.ieat.domain.AppHttpResponse;
import com.thoughtworks.ieat.domain.Group;
import com.thoughtworks.ieat.utils.ApplicationData;
import com.thoughtworks.ieat.utils.HttpUtils;

import java.util.LinkedList;
import java.util.List;

public class GroupListActivity extends Activity {

    private LinearLayout myGroupLayout;
    private ListView todayGroupLayout;

    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        this.requestWindowFeature(Window.FEATURE_ACTION_BAR);
        setContentView(R.layout.group_list);
        myGroupLayout = (LinearLayout) findViewById(R.id.my_groups);
        todayGroupLayout = (ListView) findViewById(R.id.today_groups);
        getActionBar().setTitle(R.string.title_group_list);
    }

    public void onResume() {
        super.onResume();

        new GroupListAsyncTask(this).execute();
    }

    public void createGroup(View view) {
        Intent intent = new Intent(this, GroupCreateActivity.class);
        startActivity(intent);
    }

    public class GroupListAsyncTask extends AsyncTask<Void, Void, AppHttpResponse<List<Group>>> {

        private ProgressDialog progressDialog;
        private final Context context;

        public GroupListAsyncTask(Context context) {
            this.context = context;
        }

        @Override
        public void onPreExecute() {
            progressDialog = new ProgressDialog(context);
            progressDialog.setMessage("loading group...");
            progressDialog.setCanceledOnTouchOutside(false);
            progressDialog.show();
        }

        @Override
        protected AppHttpResponse<List<Group>> doInBackground(Void... params) {
            return HttpUtils.getActiveGroups();
        }

        @Override
        protected void onPostExecute(AppHttpResponse<List<Group>> groupListResponse) {
            progressDialog.dismiss();
            if (groupListResponse.isSuccessful()) {
                List<Group> groupList = groupListResponse.getData();
                displayMyGroup(groupList);
                displayTodayGroup(groupList);
            } else {
                Toast.makeText(context, groupListResponse.getErrorMessage(), Toast.LENGTH_SHORT).show();
            }
        }
    }

    private void displayMyGroup(List<Group> myGroups) {
        for (Group myGroup : myGroups) {
            if (!myGroup.getOwner().getName().equals(IEatApplication.currentUser())) {
                continue;
            }
            GroupItemView groupItemView = new GroupItemView(getApplicationContext());
            groupItemView.addGroup(myGroup);
            myGroupLayout.addView(groupItemView);
        }
    }

    private void displayTodayGroup(List<Group> groupList) {
        List<Group> otherGroups = new LinkedList<Group>();
        for (Group group : groupList) {
            if (group.getOwner().getName().equals(IEatApplication.currentUser())) {
                continue;
            }
            otherGroups.add(group);
        }
        final GroupsAdapter adapter = new GroupsAdapter(getApplicationContext(), otherGroups);
        todayGroupLayout.setAdapter(adapter);
        todayGroupLayout.setOnItemClickListener(new AdapterView.OnItemClickListener() {

            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                Intent intent = new Intent(GroupListActivity.this, GroupTabActivity.class);
                intent.putExtra("GROUP_ID", adapter.getItem(i).getId());
                GroupListActivity.this.startActivity(intent);
            }
        });
    }
}
