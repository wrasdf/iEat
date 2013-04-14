package com.thoughtworks.ieat.activity;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.ListView;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.domain.Order;
import com.thoughtworks.ieat.view.OrderAdapter;

import java.util.List;

public class PayBackActivity extends Activity {

    private List<Order> paidOrders;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.bill_payback);

        paidOrders = (List<Order>) getIntent().getExtras().get(IEatApplication.EXTRA_ORDER_LIST);


        if (!paidOrders.isEmpty()) {
            findViewById(R.id.bill_payback_not_content).setVisibility(View.GONE);
            ListView unpaidBillList = (ListView) findViewById(R.id.bill_payback_list);
            unpaidBillList.setVisibility(View.VISIBLE);

            OrderAdapter orderAdapter = new OrderAdapter(this, paidOrders);
            unpaidBillList.setAdapter(orderAdapter);
        }
    }
}
