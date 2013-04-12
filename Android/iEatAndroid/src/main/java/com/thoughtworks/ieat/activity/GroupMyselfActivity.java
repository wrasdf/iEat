package com.thoughtworks.ieat.activity;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.domain.Group;
import com.thoughtworks.ieat.domain.Order;
import com.thoughtworks.ieat.domain.OrderDish;
import com.thoughtworks.ieat.view.DishTableRow;
import com.thoughtworks.ieat.view.OrderView;

import java.util.LinkedList;
import java.util.List;

public class GroupMyselfActivity extends Activity {

    private Group group;

    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.group_myself);

        group = (Group) getIntent().getExtras().get(IEatApplication.EXTRA_GROUP);


        OrderView myOrderView = (OrderView) findViewById(R.id.group_myself_order);

        Order myOrder = findMyOrder(group.getOrders());
        if (myOrder.getOrderDishs() != null && !myOrder.getOrderDishs().isEmpty()) {
            findViewById(R.id.group_myself_no_content).setVisibility(View.GONE);
            myOrderView.setVisibility(View.VISIBLE);
            myOrderView.addOrder(myOrder);
        }
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
}
