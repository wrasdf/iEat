package com.thoughtworks.ieat.activity;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.domain.Group;
import com.thoughtworks.ieat.domain.Order;
import com.thoughtworks.ieat.domain.OrderDish;
import com.thoughtworks.ieat.view.DishTableRow;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GroupAnalysisActivity extends Activity {

    private Group group;
    private TableLayout tableLayout;

    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.group_analysis);

        group = (Group) getIntent().getExtras().get(IEatApplication.EXTRA_GROUP);

        tableLayout = (TableLayout) findViewById(R.id.group_analysis_order_list);

        if (group.getOrders() == null || group.getOrders().isEmpty()) {
            return;
        } else {
            findViewById(R.id.group_analysis_no_content).setVisibility(View.GONE);
            addRows(tableLayout, group.getOrders());
        }

    }

    private void addRows(TableLayout tableLayout, List<Order> orders) {
        HashMap<Integer, OrderDish> dishesMap = countAllDish(orders);

        float count = 0;
        for (Map.Entry<Integer, OrderDish> orderDishEntry : dishesMap.entrySet()) {
            TableRow row = createOrderRow(orderDishEntry.getValue());
            tableLayout.addView(row);
            count += orderDishEntry.getValue().getPrice() * orderDishEntry.getValue().getQuantity();
        }

        tableLayout.addView(creatTotalCostRow(count));


        if (tableLayout.getChildCount() == 1) {
            tableLayout.getChildAt(0).setBackgroundResource(R.drawable.list_item_bg);
        } else {
            tableLayout.getChildAt(0).setBackgroundResource(R.drawable.list_item_bg_top);
        }
    }

    private DishTableRow creatTotalCostRow(float count) {
        DishTableRow tableRow = new DishTableRow(this);
        tableRow.setValue(getResources().getString(R.string.group_total_cost_label), count, null);
        tableRow.setBackgroundResource(R.drawable.list_item_bg_bottom);
        return tableRow;
    }

    private HashMap<Integer, OrderDish> countAllDish(List<Order> orders) {
        HashMap<Integer, OrderDish> dishHashMap = new HashMap<Integer, OrderDish>();
        for (Order order : orders) {
            for (OrderDish orderDish : order.getOrderDishs()) {
                OrderDish existedOrderDish = dishHashMap.get(orderDish.getDishId());
                if (existedOrderDish == null) {
                    dishHashMap.put(orderDish.getDishId(), orderDish);
                } else {
                    existedOrderDish.setQuantity(existedOrderDish.getQuantity() + orderDish.getQuantity());
                    dishHashMap.put(existedOrderDish.getDishId(), existedOrderDish);
                }
            }
        }
        return dishHashMap;
    }

    private TableRow createOrderRow(OrderDish orderDish) {
        DishTableRow tableRow = new DishTableRow(this);
        tableRow.setValue(orderDish.getName(), orderDish.getPrice(), orderDish.getQuantity());
        return tableRow;
    }
}
