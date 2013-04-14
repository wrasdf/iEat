package com.thoughtworks.ieat.activity;

import android.app.AlertDialog;
import android.app.Fragment;
import android.app.FragmentTransaction;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.domain.AppHttpResponse;
import com.thoughtworks.ieat.domain.Group;
import com.thoughtworks.ieat.domain.Restaurant;
import com.thoughtworks.ieat.service.Server;
import com.thoughtworks.ieat.view.LabelItemView;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

public class GroupCreateActivity extends ActionBarActivity {

    private TimePicker timePicker;
    private EditText groupNameView;
    private RadioGroup choosingRestaurantList;
    private List<Restaurant> allRestaurants;
    private Button selectRestaurantButton;

    @Override
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.group_create);
        groupNameView = (EditText) findViewById(R.id.created_group_name);
        choosingRestaurantList = (RadioGroup) findViewById(R.id.choosing_restaurant_list);
        selectRestaurantButton = (Button) findViewById(R.id.select_other_restaurant_button);

        timePicker = (TimePicker) findViewById(R.id.time_picker);
        initTimePicker(timePicker);
        setTitle(R.string.group_create_title);
    }

    @Override
    public void onResume() {
        super.onResume();
        new RestaurantListAsyncTask().execute();
    }

    public void createGroup() {
        String groupName = groupNameView.getText().toString();
        if (groupName == null) {
            Toast.makeText(this, getResources().getString(R.string.input_error_group_name_is_null), Toast.LENGTH_SHORT);
            return;
        }

        RadioButton checkedRestaurant = (RadioButton) findViewById(choosingRestaurantList.getCheckedRadioButtonId());
        int selectedRestaurantId = checkedRestaurant.getId();

        Integer hour = timePicker.getCurrentHour();
        Integer minute = timePicker.getCurrentMinute();
        Calendar selectedTime = Calendar.getInstance();
        selectedTime.set(Calendar.HOUR, hour);
        selectedTime.set(Calendar.MINUTE, minute);
        selectedTime.set(Calendar.SECOND, 0);

        CreateGroupAsyncTask createGroupAsyncTask = new CreateGroupAsyncTask();
        createGroupAsyncTask.execute(groupName, String.valueOf(selectedRestaurantId), new SimpleDateFormat(IEatApplication.DATE_PATTERN).format(selectedTime.getTime()));
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.group_create, menu);
        getActionBarHelper().setDisplayHomeAsUpEnabled(true);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case android.R.id.home:
            case R.id.actionbar_home_button:
                gotoDashBoard();
                break;
            case R.id.group_create_button:
                createGroup();
                break;
        }
        return false;
    }

    private void gotoDashBoard() {
        Intent loginIntent = new Intent(this, GroupListActivity.class);
        startActivity(loginIntent);
        finish();
    }

    public void showRestaurantsDialog(View view) {
//        FragmentTransaction ft = getFragmentManager().beginTransaction();
//        Fragment existedFragment = getFragmentManager().findFragmentByTag("dialog");
//        if (existedFragment != null) {
//            ft.remove(existedFragment);
//        }
//        ft.addToBackStack(null);


        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle(R.string.active_group_list_label);
        builder.setSingleChoiceItems(new BaseAdapter() {
                                         public int getCount() {
                                             return allRestaurants.size();
                                         }

                                         public Object getItem(int i) {
                                             return allRestaurants.get(i);
                                         }

                                         public long getItemId(int i) {
                                             return i;
                                         }

                                         public View getView(int i, View view, ViewGroup viewGroup) {
                                             LabelItemView restaurantLabel = new LabelItemView(GroupCreateActivity.this);
                                             restaurantLabel.setText(allRestaurants.get(i).getName());
                                             restaurantLabel.setContentDescription(String.valueOf(allRestaurants.get(i).getId()));
                                             restaurantLabel.setBackgroundDrawable(null);
                                             return restaurantLabel;
                                         }
                                     }, 0,
                new DialogInterface.OnClickListener() {

                    public void onClick(DialogInterface dialogInterface, int i) {
                        dialogInterface.dismiss();
                        addRestaurant(allRestaurants.get(i));
                        checkRestaurant(allRestaurants.get(i).getId());
                    }
                }
        );
        builder.create().show();
    }

    private void addRestaurant(Restaurant selectedRestaurant) {

        Integer restaurantId = selectedRestaurant.getId();
        for (int radioIndex = 0; radioIndex < choosingRestaurantList.getChildCount(); radioIndex++) {
            if (restaurantId.equals(choosingRestaurantList.getChildAt(radioIndex).getId())) {
                choosingRestaurantList.clearCheck();
                choosingRestaurantList.check(radioIndex + 1);
                return;
            }
        }

        if (choosingRestaurantList.getChildCount() > 2) {
            choosingRestaurantList.removeViewAt(choosingRestaurantList.getChildCount() - 1);
        }

        RadioButton child = new RadioButton(this);
        child.setText(selectedRestaurant.getName());
        child.setId(selectedRestaurant.getId());

        choosingRestaurantList.addView(child);
    }

    private void checkRestaurant(int restaurantLocation) {
        choosingRestaurantList = (RadioGroup) findViewById(R.id.choosing_restaurant_list);
        choosingRestaurantList.clearCheck();
        choosingRestaurantList.check(restaurantLocation);
    }


    private void initTimePicker(TimePicker timePicker) {
        timePicker.setCurrentHour(11);
        timePicker.setCurrentMinute(30);
        timePicker.setIs24HourView(false);
    }

    private class CreateGroupAsyncTask extends AsyncTask<String, Void, AppHttpResponse<Group>> {

        private ProgressDialog progressDialog;

        @Override
        protected void onPreExecute() {
            progressDialog = new ProgressDialog(GroupCreateActivity.this);
            progressDialog.setMessage("saving...");
            progressDialog.setCanceledOnTouchOutside(false);
            progressDialog.show();

        }

        @Override
        protected AppHttpResponse<Group> doInBackground(String... params) {
            String groupName = params[0];
            String groupId = params[1];
            String dueTimeStr = params[2];
            AppHttpResponse<Group> groupCreateResponse = Server.createGroup(groupName, groupId, dueTimeStr);
            if (groupCreateResponse.isSuccessful()) {
                groupCreateResponse = Server.getGroup(groupCreateResponse.getData().getId());
            }
            return groupCreateResponse;
        }

        protected void onPostExecute(AppHttpResponse<Group> result) {
            progressDialog.dismiss();
            if (result.isSuccessful()) {
                Intent intent = new Intent(GroupCreateActivity.this, GroupTabActivity.class);
                intent.putExtra(IEatApplication.EXTRA_GROUP, result.getData());
                intent.putExtra(IEatApplication.EXTRA_TAG, getResources().getString(R.string.group_info_tab_label));
                GroupCreateActivity.this.startActivity(intent);
                finish();
            } else {
                Toast.makeText(GroupCreateActivity.this, result.getErrorMessage(), Toast.LENGTH_SHORT).show();
            }


        }

    }

    private class RestaurantListAsyncTask extends AsyncTask<Void, Void, AppHttpResponse<List<Restaurant>>> {

        private ProgressDialog progressDialog;

        @Override
        public void onPreExecute() {
            progressDialog = new ProgressDialog(GroupCreateActivity.this);
            progressDialog.setMessage("loading ...");
            progressDialog.setCanceledOnTouchOutside(false);
            progressDialog.show();
        }

        @Override
        protected AppHttpResponse<List<Restaurant>> doInBackground(Void... voids) {
            return Server.getRestaurants();
        }

        @Override
        protected void onPostExecute(AppHttpResponse<List<Restaurant>> response) {
            progressDialog.dismiss();
            if (response.isSuccessful()) {
                allRestaurants = response.getData();
                selectRestaurantButton.setOnClickListener(new View.OnClickListener() {
                    public void onClick(View view) {
                        showRestaurantsDialog(view);
                    }
                });
                addRestaurant(allRestaurants.get(0));
                addRestaurant(allRestaurants.get(1));
                checkRestaurant(allRestaurants.get(0).getId());
            } else {
                AlertDialog.Builder builder = new AlertDialog.Builder(GroupCreateActivity.this);
                builder.setMessage(getResources().getString(R.string.loading_restaurants_fail));
                builder.setCancelable(true);
                AlertDialog alertDialog = builder.create();
                alertDialog.show();
            }
        }
    }
}
