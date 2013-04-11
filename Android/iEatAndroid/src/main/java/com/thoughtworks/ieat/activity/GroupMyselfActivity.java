package com.thoughtworks.ieat.activity;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.TableLayout;
import android.widget.TextView;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.domain.Group;
import com.thoughtworks.ieat.domain.Order;
import com.thoughtworks.ieat.domain.OrderDish;
import com.thoughtworks.ieat.view.DishTableRow;

import java.util.LinkedList;
import java.util.List;

public class GroupMyselfActivity extends Activity {

    private Group group;

    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.group_myself);

        group = (Group) getIntent().getExtras().get(IEatApplication.EXTRA_GROUP);

        TableLayout tableLayout = (TableLayout) findViewById(R.id.group_myself_order_table);

        Order myOrder = findMyOrder(group.getOrders());
        if (myOrder.getOrderDishs() != null && !myOrder.getOrderDishs().isEmpty()) {
            findViewById(R.id.group_myself_no_content).setVisibility(View.GONE);
            findViewById(R.id.group_myself_order_list).setVisibility(View.VISIBLE);
            addOrderRows(tableLayout, myOrder);
        }
    }

    private void addOrderRows(TableLayout tableLayout, Order order) {
        ((TextView)findViewById(R.id.group_myself_username)).setText(order.getUser().getName());
        float count = 0;
        for (OrderDish orderDish : order.getOrderDishs()) {
            DishTableRow dishTableRow = new DishTableRow(this);
            dishTableRow.setValue(orderDish.getName(), orderDish.getPrice(), orderDish.getQuantity());
            tableLayout.addView(dishTableRow);
            count += orderDish.getPrice() * orderDish.getQuantity();
        }
        tableLayout.addView(createTotalCostRow(count));
    }

    private DishTableRow createTotalCostRow(float count) {
        DishTableRow tableRow = new DishTableRow(this);
        tableRow.setValue(getResources().getString(R.string.group_total_cost_label), count, null);
        tableRow.setBackgroundResource(R.drawable.list_item_bg_bottom);
        return tableRow;
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
