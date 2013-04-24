package com.thoughtworks.ieat.activity;

import android.app.Activity;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.activity.asynctask.PostProcessor;
import com.thoughtworks.ieat.domain.AppHttpResponse;
import com.thoughtworks.ieat.domain.Group;
import com.thoughtworks.ieat.domain.Order;
import com.thoughtworks.ieat.domain.OrderDish;
import com.thoughtworks.ieat.service.Server;
import com.thoughtworks.ieat.view.OrderView;

import java.util.LinkedList;
import java.util.List;

public class GroupMyselfActivity extends Activity implements PostProcessor{

    private Group group;
    private OrderView myOrderView;

    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.group_myself);

        group = (Group) getIntent().getExtras().get(IEatApplication.EXTRA_GROUP);


        myOrderView = (OrderView) findViewById(R.id.group_myself_order);

        Order myOrder = findMyOrder(group.getOrders());
        if (myOrder.getOrderDishs() != null && !myOrder.getOrderDishs().isEmpty()) {
            findViewById(R.id.group_myself_no_content).setVisibility(View.GONE);
            myOrderView.setVisibility(View.VISIBLE);
            myOrderView.addOrder(myOrder);
        }

//        attachRemoveAction(myOrder);
    }

    private void attachRemoveAction(Order myOrder) {
        myOrderView.addDeleteAction(new View.OnClickListener() {
            public void onClick(View v) {
                new DeleteOrderAysncTask(GroupMyselfActivity.this, GroupMyselfActivity.this);
            }
        });
    }

    public void process(AppHttpResponse appHttpResponse) {
        findViewById(R.id.group_myself_no_content).setVisibility(View.VISIBLE);
        myOrderView.setVisibility(View.GONE);
    }


    private Order findMyOrder(List<Order> orders) {
        for (Order order : orders) {
            if (order.getUser().getName().equals(IEatApplication.currentUser())) {
                return order;
            }
        }
        Order emptyOrder = new Order();
        emptyOrder.setOrderDishs(new LinkedList<OrderDish>());
        return emptyOrder;
    }

    @Override
    protected void onResume() {
        super.onResume();
    }

    private class DeleteOrderAysncTask extends AsyncTask<Integer, Void, AppHttpResponse<Boolean>> {
        private final Activity activity;
        private final PostProcessor processor;

        public DeleteOrderAysncTask(Activity activity, PostProcessor process) {
            this.activity = activity;
            this.processor = process;
        }

        @Override
        protected AppHttpResponse<Boolean> doInBackground(Integer... params) {
            return Server.deleteOrder(params[0]);
        }

        @Override
        protected void onPostExecute(AppHttpResponse<Boolean> appHttpResponse) {
            if (appHttpResponse.isSuccessful()) {
                processor.process(appHttpResponse);
            } else {
                Toast.makeText(activity, "Fails to delete order", Toast.LENGTH_SHORT).show();
            }
        }
    }
}
