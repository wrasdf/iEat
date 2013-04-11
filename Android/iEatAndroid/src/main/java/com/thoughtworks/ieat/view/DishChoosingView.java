package com.thoughtworks.ieat.view;

import android.content.Context;
import android.text.Editable;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.NumberPicker;
import android.widget.TextView;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.domain.Dish;

public class DishChoosingView extends LinearLayout {
    private final Dish dish;
    private final TextView dishNameView;
    private final EditText dishCountView;
    private final TextView dishPriceView;
    private final DishesAdapter dishesAdapter;

    private int MIN_VALID_VALUE = 0;

    public DishChoosingView(Context context, DishesAdapter dishesAdapter, Dish dish) {
        super(context);
        this.dish = dish;
        this.dishesAdapter = dishesAdapter;

        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        inflater.inflate(R.layout.dish_choosing, this);

        dishNameView = (TextView) findViewById(R.id.dish_name);
        dishCountView = (EditText) findViewById(R.id.dish_count);
        dishPriceView = ((TextView) findViewById(R.id.dish_price_value));
        setText(dish);

        attachCountAction();
    }

    private void attachCountAction() {

//        dishCountView.setOnEditorActionListener(new TextView.OnEditorActionListener() {
//            public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
//                count = getSelectedCount();
//                return false;
//            }
//        });

        findViewById(R.id.dish_count_plus).setOnClickListener(new OnClickListener() {
            public void onClick(View v) {
                plus(v);
            }
        });

        findViewById(R.id.dish_count_minus).setOnClickListener(new OnClickListener() {
            public void onClick(View v) {
                minus(v);
            }
        });

    }

    public Dish getDish() {
        return dish;
    }


    private void setText(Dish dish) {
        dishNameView.setText(dish.getName());
        dishPriceView.setText(String.valueOf(dish.getPrice()));
    }

    private void plus(View view) {
        Integer count = getSelectedCount() ;
        count++;
        dishCountView.setText(count.toString());
        dishesAdapter.getSelectedDishes().put(dish, count);
    }

    private void minus(View view) {
        Integer count = getSelectedCount() ;
        count--;
        if (count < MIN_VALID_VALUE) {
            count = MIN_VALID_VALUE;
        }
        dishCountView.setText(count.toString());
        if (count == MIN_VALID_VALUE) {
            dishesAdapter.getSelectedDishes().remove(dish);
        } else {
            dishesAdapter.getSelectedDishes().put(dish, count);
        }

    }

    public Integer getSelectedCount() {
        Editable text = dishCountView.getText();
        Integer selectedCount = Integer.valueOf(text.toString());
        return Math.max(MIN_VALID_VALUE, selectedCount);
    }
}
