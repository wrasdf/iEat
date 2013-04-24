package com.thoughtworks.ieat.view;

import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TableLayout;
import android.widget.TextView;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.domain.Order;
import com.thoughtworks.ieat.domain.OrderDish;

public class OrderView extends LinearLayout {

    private final Context context;
    private Button deleteButton = null;
    private TableLayout tableLayout = null;

    public OrderView(Context context, AttributeSet attrs) {
        super(context, attrs);
        this.context = context;
        inflateLayout(context);
    }

    public OrderView(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        this.context = context;
        inflateLayout(context);
    }

    public OrderView(Context context) {
        super(context);
        this.context = context;
        inflateLayout(context);
    }

    private void inflateLayout(Context context) {
        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        inflater.inflate(R.layout.order_table, this);

        tableLayout = (TableLayout) findViewById(R.id.order_table_content);
        deleteButton = ((Button) findViewById(R.id.delete));
    }

    public void addOrder(Order order) {
        addOrderRows(order);
    }

    public void addDeleteAction(OnClickListener deleteListener) {
        deleteButton.setVisibility(View.VISIBLE);
        deleteButton.setOnClickListener(deleteListener);
    }


    private void addOrderRows(Order order) {
        ((TextView) findViewById(R.id.order_table_header_username)).setText(order.getUser().getName());
        float count = 0;
        for (OrderDish orderDish : order.getOrderDishs()) {
            DishTableRow dishTableRow = new DishTableRow(context);
            dishTableRow.setValue(orderDish.getName(), orderDish.getPrice(), orderDish.getQuantity());
            tableLayout.addView(dishTableRow);
            count += orderDish.getPrice() * orderDish.getQuantity();
        }
        tableLayout.addView(createTotalCostRow(count));
    }

    private DishTableRow createTotalCostRow(float count) {
        DishTableRow tableRow = new DishTableRow(context);
        tableRow.setValue(getResources().getString(R.string.group_total_cost_label), count, null);
        tableRow.setBackgroundResource(R.drawable.list_item_bg_bottom);
        return tableRow;
    }
}
