package com.thoughtworks.ieat.activity;

import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.Toast;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.domain.AppHttpResponse;
import com.thoughtworks.ieat.domain.Dish;
import com.thoughtworks.ieat.domain.Dishes;
import com.thoughtworks.ieat.domain.Group;
import com.thoughtworks.ieat.service.Server;
import com.thoughtworks.ieat.view.DishesAdapter;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class OrderCreateActivity extends ActionBarActivity {

    private Group group;
    private ListView dishesView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.order_create);
        group = (Group) getIntent().getExtras().get(IEatApplication.EXTRA_GROUP);

        dishesView = (ListView) findViewById(R.id.dish_list);
        setTitle(group.getRestaurant().getName());
    }

    @Override
    protected void onResume() {
        super.onResume();

        new DishListAsyncTask(this).execute(group.getId());
    }

    public void createOrder() {
        ListAdapter dishesAdapter = dishesView.getAdapter();
        if (dishesAdapter != null) {
            DishesAdapter dishes = (DishesAdapter) dishesAdapter;
            Map<Dish,Integer> selectedDishes = dishes.getSelectedDishes();

            if (selectedDishes.isEmpty()) {
                Toast.makeText(this, R.string.dish_choosing_noting_message, Toast.LENGTH_SHORT).show();
                return;
            }

            new OrderCreateAsyncTask(this).execute(selectedDishes);
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.order_create, menu);
        getActionBarHelper().setDisplayHomeAsUpEnabled(true);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.order_create_confirm:
                createOrder();
                break;
            case R.id.actionbar_home_button:
            case android.R.id.home:
                onBackPressed();
                break;
        }
        return false;
    }

    private class DishListAsyncTask extends AsyncTask<Integer, Void, AppHttpResponse<List<Dishes>>>{

        private ProgressDialog progressDialog;
        private final Context context;

        public DishListAsyncTask(Context activity) {
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
        protected AppHttpResponse<List<Dishes>> doInBackground(Integer... params) {
            Integer groupId = params[0];
            return Server.listDishes(groupId);
        }

        @Override
        protected void onPostExecute(AppHttpResponse<List<Dishes>> appHttpResponse) {
            progressDialog.dismiss();
            if (appHttpResponse.isSuccessful()) {
                displayDishes(appHttpResponse.getData());
            } else {
                Toast.makeText(OrderCreateActivity.this, appHttpResponse.getErrorMessage(), Toast.LENGTH_SHORT).show();
            }
        }
    }

    private void displayDishes(List<Dishes> dishes) {
        DishesAdapter dishesAdapter = new DishesAdapter(this, dishes);
        dishesView.setAdapter(dishesAdapter);
    }

    private class OrderCreateAsyncTask extends AsyncTask<Map<Dish, Integer>, Void, AppHttpResponse<Group>>{

        private ProgressDialog progressDialog;
        private final Context context;

        public OrderCreateAsyncTask(Context activity) {
            this.context = activity;
        }

        @Override
        protected void onPreExecute() {
            progressDialog = new ProgressDialog(OrderCreateActivity.this);
            progressDialog.setMessage("saving...");
            progressDialog.setCanceledOnTouchOutside(false);
            progressDialog.show();

        }


        @Override
        protected AppHttpResponse<Group> doInBackground(Map<Dish, Integer>... params) {
            List<Map<String, String>> selectedDishList = translatePostDataFormat(params[0]);
            AppHttpResponse<Group> orderCreateResponse = Server.createOrder(group.getId(), selectedDishList);
            if (orderCreateResponse.isSuccessful()) {
                orderCreateResponse = Server.getGroup(group.getId());
            }
            return orderCreateResponse;
        }

        @Override
        protected void onPostExecute(AppHttpResponse<Group> response) {
            progressDialog.dismiss();
            if (response.isSuccessful()) {
                Intent intent = new Intent(OrderCreateActivity.this, GroupTabActivity.class);
                intent.putExtra(IEatApplication.EXTRA_GROUP, response.getData());
                if (response.getData().getOwner().getName().equals(IEatApplication.currentUser())) {
                    intent.putExtra(IEatApplication.EXTRA_TAG, String.valueOf(R.string.group_myself_tab_label));
                } else {
                    intent.putExtra(IEatApplication.EXTRA_TAG, String.valueOf(R.string.group_member_tab_label));
                }
                context.startActivity(intent);
            } else {
                Toast.makeText(OrderCreateActivity.this, response.getErrorMessage(), Toast.LENGTH_SHORT).show();
            }
        }

        private List<Map<String, String>> translatePostDataFormat(Map<Dish, Integer> selectedDishes) {
            LinkedList<Map<String, String>> selectedDishesList = new LinkedList<Map<String, String>>();
            for (Map.Entry<Dish, Integer> dishIntegerEntry : selectedDishes.entrySet()) {
                if (dishIntegerEntry.getValue() <= 0) continue;

                HashMap<String, String> dishWithCount = new HashMap<String, String>();
                dishWithCount.put("id", dishIntegerEntry.getKey().getId().toString());
                dishWithCount.put("quantity", dishIntegerEntry.getValue().toString());
                selectedDishesList.add(dishWithCount);
            }
            return selectedDishesList;
        }
    }
}
