package com.thoughtworks.ieat.activity;

import android.app.*;
import android.content.DialogInterface;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.domain.AppHttpResponse;
import com.thoughtworks.ieat.domain.Group;
import com.thoughtworks.ieat.domain.Restaurant;
import com.thoughtworks.ieat.domain.wrapper.RestaurantsWrapper;
import com.thoughtworks.ieat.utils.HttpUtils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

public class GroupCreateActivity extends Activity {

    private TimePicker timePicker;
    private EditText groupNameView;
    private int selectedRestaurantId;
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
    }

    @Override
    public void onResume() {
        super.onResume();
        RestaurantListAsyncTask restaurantListAsyncTask = new RestaurantListAsyncTask();
        restaurantListAsyncTask.execute();
    }

    public void create(View view) {
        String groupName = groupNameView.getText().toString();
        if (groupName == null) {
            Toast.makeText(this, getResources().getString(R.string.input_error_group_name_is_null), Toast.LENGTH_SHORT);
            return;
        }

        RadioButton checkedRestaurant = (RadioButton) findViewById(choosingRestaurantList.getCheckedRadioButtonId());
        selectedRestaurantId = Integer.valueOf(checkedRestaurant.getContentDescription().toString());

        Integer hour = timePicker.getCurrentHour();
        Integer minute = timePicker.getCurrentMinute();
        Calendar selectedTime = Calendar.getInstance();
        selectedTime.set(Calendar.HOUR, hour);
        selectedTime.set(Calendar.MINUTE, minute);
        selectedTime.set(Calendar.SECOND, 0);

        CreateGroupAsyncTask createGroupAsyncTask = new CreateGroupAsyncTask();
        createGroupAsyncTask.execute(groupName, new SimpleDateFormat(IEatApplication.DATE_PATTERN).format(selectedTime.getTime()), String.valueOf(selectedRestaurantId));
    }

    public void showRestaurantsDialog(View view) {
        FragmentTransaction ft = getFragmentManager().beginTransaction();
        Fragment exsitedFragment = getFragmentManager().findFragmentByTag("dialog");
        if (exsitedFragment != null) {
            ft.remove(exsitedFragment);
        }
        ft.addToBackStack(null);


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
                                             TextView textView = new TextView(GroupCreateActivity.this);
                                             textView.setText(allRestaurants.get(i).getName());
                                             return textView;
                                         }
                                     }, 0,
                new DialogInterface.OnClickListener() {

                    public void onClick(DialogInterface dialogInterface, int i) {
                        dialogInterface.dismiss();
                        addRestaurant(i, true);
                    }
                }
        );
        builder.create().show();
    }

    private void addRestaurant(int restaurantIndex, boolean doCheck) {

        boolean hasContain = false;
        Integer restaurantId = allRestaurants.get(restaurantIndex).getId();
        for (int radioIndex = 0; radioIndex < choosingRestaurantList.getChildCount(); radioIndex++) {
            if (restaurantId.equals(Integer.valueOf(choosingRestaurantList.getChildAt(radioIndex).getContentDescription().toString()))) {
                hasContain = true;
                if (doCheck) {
                    choosingRestaurantList.clearCheck();
                    choosingRestaurantList.check(radioIndex);
                }
                return;
            }
        }

        if (!hasContain) {
            if (choosingRestaurantList.getChildCount() > 2) {
                choosingRestaurantList.removeViewAt(choosingRestaurantList.getChildCount() - 1);
            }

            RadioButton child = new RadioButton(this);
            child.setText(allRestaurants.get(restaurantIndex).getName());
            child.setContentDescription(String.valueOf(restaurantIndex));

            choosingRestaurantList.addView(child);
            if (doCheck) {
                choosingRestaurantList.clearCheck();
                choosingRestaurantList.check(choosingRestaurantList.getChildCount());
            }
        }
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
            String restaurantId = params[1];
            String dueTimeStr = params[2];
            return HttpUtils.createGroup(groupName, restaurantId, dueTimeStr);
        }

        protected void onPostExecute(AppHttpResponse<Group> result) {
            progressDialog.dismiss();
            if (result.isSuccessful()) {

            } else {
                Toast.makeText(GroupCreateActivity.this, result.getErrorMessage(), Toast.LENGTH_SHORT).show();
            }


        }

    }
//
//    private class RestaurantCheckListDialog extends DialogFragment {
//
//        @Override
//        public Dialog onCreateDialog(Bundle savedInstanceState) {
//            AlertDialog.Builder dialogBuilder = new AlertDialog.Builder(getActivity());
//            dialogBuilder.setTitle(R.string.choosing_restaurant_list_label);
//            return dialogBuilder.create();
//        }
//    }

    private class RestaurantListAsyncTask extends AsyncTask<Void, Void, AppHttpResponse<RestaurantsWrapper>> {

        private ProgressDialog progressDialog;

        @Override
        public void onPreExecute() {
            progressDialog = new ProgressDialog(GroupCreateActivity.this);
            progressDialog.setMessage("loading ...");
            progressDialog.setCanceledOnTouchOutside(false);
            progressDialog.show();
        }

        @Override
        protected AppHttpResponse<RestaurantsWrapper> doInBackground(Void... voids) {
            return HttpUtils.getRestaurants();
        }

        @Override
        protected void onPostExecute(AppHttpResponse<RestaurantsWrapper> response) {
            progressDialog.dismiss();
            if (response.isSuccessful()) {
                allRestaurants = response.getData().getAllRestaurants();
                selectRestaurantButton.setOnClickListener(new View.OnClickListener() {
                    public void onClick(View view) {
                        showRestaurantsDialog(view);
                    }
                });
                addRestaurant(0, true);
                addRestaurant(1, false);
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
