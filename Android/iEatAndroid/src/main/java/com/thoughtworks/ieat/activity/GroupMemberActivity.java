package com.thoughtworks.ieat.activity;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.ListView;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.domain.Group;
import com.thoughtworks.ieat.domain.Order;
import com.thoughtworks.ieat.view.OrderAdapter;

import java.util.LinkedList;
import java.util.List;


public class GroupMemberActivity extends Activity {

    private Group group;

    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.group_member);

        group = (Group) getIntent().getExtras().get(IEatApplication.EXTRA_GROUP);



        List<Order> otherMemberOrders = removeCurrentUserOrder(group.getOrders());
        if (!otherMemberOrders.isEmpty()) {
            findViewById(R.id.group_member_no_content).setVisibility(View.GONE);

            ListView memberOrdersListView = (ListView) findViewById(R.id.group_memeber_order_list);
            memberOrdersListView.setVisibility(View.VISIBLE);
            OrderAdapter orderAdapter = new OrderAdapter(this, otherMemberOrders);
            memberOrdersListView.setAdapter(orderAdapter);
        }
    }

    private List<Order> removeCurrentUserOrder(List<Order> orders) {
        LinkedList<Order> otherUserOrders = new LinkedList<Order>();
        for (Order order : orders) {
            if (!order.getUser().getName().equals(IEatApplication.currentUser()) &&
                    !order.getOrderDishs().isEmpty()) {
                otherUserOrders.add(order);
            }
        }
        return otherUserOrders;
    }
}
