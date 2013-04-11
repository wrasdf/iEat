package com.thoughtworks.ieat.view;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TableRow;
import android.widget.TextView;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.activity.GroupAnalysisActivity;

public class DishTableRow extends TableRow {

    private final TextView dishNameView;
    private final TextView dishPriceView;
    private final TextView dishQuantityiew;

    public DishTableRow(Context activity) {
        super(activity);

        LayoutInflater inflater = (LayoutInflater) activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        inflater.inflate(R.layout.dish_row, this);

        dishNameView = (TextView) findViewById(R.id.dish_row_name);
        dishPriceView = (TextView) findViewById(R.id.dish_row_price);
        dishQuantityiew = (TextView) findViewById(R.id.dish_row_quantity);
        setStyle();
    }

    private void setStyle() {
        setBackgroundResource(R.drawable.list_item_bg_rectangle);
        setPadding(getResources().getDimensionPixelSize(R.dimen.device_padding),
                getResources().getDimensionPixelSize(R.dimen.vertical_padding),
                getResources().getDimensionPixelSize(R.dimen.vertical_padding),
                getResources().getDimensionPixelSize(R.dimen.device_padding));
    }

    public void setValue(String dishName, float price, Integer quantity) {
        dishNameView.setText(dishName);
        dishPriceView.setText(String.valueOf(price));
        if (quantity != null) {
            dishQuantityiew.setVisibility(View.VISIBLE);
            dishQuantityiew.setText(String.valueOf(quantity));
        }
    }
}
