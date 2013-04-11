package com.thoughtworks.ieat.activity;

import android.os.Bundle;
import android.view.View;
import android.widget.ListView;
import android.widget.TextView;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.domain.Order;
import com.thoughtworks.ieat.view.OrderAdapter;

import java.util.List;

public class UnpaidOrderActivity extends ActionBarActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.bill_unpaid);
        List<Order> unpaidOrders = (List<Order>) getIntent().getExtras().get(IEatApplication.EXTRA_ORDER_LIST);

        if (!unpaidOrders.isEmpty()) {
            findViewById(R.id.bill_unpaid_not_content).setVisibility(View.GONE);
            ListView unpaidBillList = (ListView) findViewById(R.id.bill_unpaid_list);
            unpaidBillList.setVisibility(View.VISIBLE);

            OrderAdapter orderAdapter = new OrderAdapter(this, unpaidOrders);
            unpaidBillList.setAdapter(orderAdapter);
        }
    }
}
