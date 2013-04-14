package com.thoughtworks.ieat.activity;

import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.Toast;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.activity.asynctask.BillAsyncTask;
import com.thoughtworks.ieat.activity.asynctask.PostProcessor;
import com.thoughtworks.ieat.domain.AppHttpResponse;
import com.thoughtworks.ieat.domain.Group;
import com.thoughtworks.ieat.domain.MyBill;
import com.thoughtworks.ieat.service.Server;
import com.thoughtworks.ieat.view.EmptyAdapter;
import com.thoughtworks.ieat.view.GroupsAdapter;

import java.util.LinkedList;
import java.util.List;

public class GroupListActivity extends ActionBarActivity implements PostProcessor<MyBill>{

    private ListView myGroupLayout;
    private ListView todayGroupLayout;

    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);

        setContentView(R.layout.group_list);
        myGroupLayout = (ListView) findViewById(R.id.my_groups);
        todayGroupLayout = (ListView) findViewById(R.id.today_groups);
        IEatApplication.addActivity(this);
    }

    public void onResume() {
        super.onResume();
        new GroupListAsyncTask(this).execute();
    }

    public void createGroup(View view) {
        Intent intent = new Intent(this, GroupCreateActivity.class);
        startActivity(intent);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.group_list, menu);
        setTitle(R.string.group_list_title);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.menu_logout_button:
                logout();
                break;
            case R.id.menu_recharge_button:
                goToRecharge();
                break;
        }
        return false;
    }

    private void goToRecharge() {
        new BillAsyncTask(this, this).execute();
    }

    private void logout() {
        ((IEatApplication) getApplication()).logout();

        goToLogin();
    }

    private void goToLogin() {
        Intent loginIntent = new Intent(this, LoginActivity.class);
        loginIntent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK);
        startActivity(loginIntent);
        finish();
    }

    public void process(AppHttpResponse<MyBill> appHttpResponse) {
        Intent intent = new Intent(this, BillActivity.class);
        intent.putExtra(IEatApplication.EXTRA_BILL, appHttpResponse.getData());
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
            return Server.getActiveGroups();
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
        List<Group> myGroupList = new LinkedList<Group>();
        for (Group myGroup : myGroups) {
            if (!myGroup.getOwner().getName().equals(IEatApplication.currentUser())) {
                continue;
            }
            myGroupList.add(myGroup);
        }

        if (myGroupList.isEmpty()) {
            EmptyAdapter emptyAdapter = new EmptyAdapter(getApplicationContext(), getResources().getString(R.string.my_group_list_empty_reminder));
            myGroupLayout.setAdapter(emptyAdapter);
            return;
        }
        final GroupsAdapter adapter = new GroupsAdapter(getApplicationContext(), myGroupList);
        myGroupLayout.setAdapter(adapter);
        myGroupLayout.setOnItemClickListener(new AdapterView.OnItemClickListener() {

            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                new ClickedGroupAsyncTask(GroupListActivity.this).execute(adapter.getItem(i).getId());
            }
        });

    }

    private void displayTodayGroup(List<Group> groupList) {
        List<Group> otherGroups = new LinkedList<Group>();
        for (Group group : groupList) {
            if (group.getOwner().getName().equals(IEatApplication.currentUser())) {
                continue;
            }
            otherGroups.add(group);
        }

        if (otherGroups.isEmpty()) {
            todayGroupLayout.setAdapter(new EmptyAdapter(getApplicationContext(), getResources().getString(R.string.active_group_list_empty_reminder)));
            return;
        }

        final GroupsAdapter adapter = new GroupsAdapter(getApplicationContext(), otherGroups);
        todayGroupLayout.setAdapter(adapter);
        todayGroupLayout.setOnItemClickListener(new AdapterView.OnItemClickListener() {

            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {

                new ClickedGroupAsyncTask(GroupListActivity.this).execute(adapter.getItem(i).getId());
            }
        });
    }

    private class ClickedGroupAsyncTask extends AsyncTask<Integer, Void, AppHttpResponse<Group>>{
        private final Context context;
        private ProgressDialog progressDialog;

        public ClickedGroupAsyncTask(Context activity) {
            this.context = activity;
        }

        @Override
        public void onPreExecute() {
            progressDialog = new ProgressDialog(context);
            progressDialog.setMessage("loading group...");
            progressDialog.setCanceledOnTouchOutside(false);
            progressDialog.show();
        }

        @Override
        protected AppHttpResponse<Group> doInBackground(Integer... params) {
            return Server.getGroup(params[0]);
        }

        @Override
        protected void onPostExecute(AppHttpResponse<Group> response) {
            progressDialog.dismiss();
            if (response.isSuccessful()) {
                Intent intent = new Intent(GroupListActivity.this, GroupTabActivity.class);
                intent.putExtra(IEatApplication.EXTRA_GROUP, response.getData());
                GroupListActivity.this.startActivity(intent);
            }
        }
    }
}
