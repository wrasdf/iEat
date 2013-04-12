package com.thoughtworks.ieat.view;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import com.thoughtworks.ieat.domain.Order;

import java.util.List;

public class OrderAdapter extends BaseAdapter{

    private final Context context;
    private final List<Order> orders;

    public OrderAdapter(Context context, List<Order> orders) {
        this.context = context;
        this.orders = orders;
    }

    public int getCount() {
        return orders.size();
    }

    public Order getItem(int position) {
        return orders.get(position);
    }

    public long getItemId(int position) {
        return orders.get(position).getId();
    }

    public View getView(int i, View view, ViewGroup viewGroup) {
        OrderView orderView = new OrderView(context);
        orderView.addOrder(getItem(i));
        return orderView;
    }
}
