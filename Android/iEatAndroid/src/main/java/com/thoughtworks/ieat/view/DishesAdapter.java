package com.thoughtworks.ieat.view;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.domain.Dish;
import com.thoughtworks.ieat.domain.Dishes;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class DishesAdapter extends BaseAdapter {
    private final Context context;
    private final List<Dishes> disheses;
    private Map<Dish, Integer> selectedDishes = new HashMap<Dish, Integer>();
    private final LinkedList<Integer> sizeCount;

    public DishesAdapter(Context context, List<Dishes> disheses) {
        this.context = context;
        this.disheses = disheses;

        sizeCount = new LinkedList<Integer>();
        for (int i = 0; i < disheses.size(); i++) {
            if (i == 0) {
                sizeCount.add(disheses.get(0).getDishes().size() + 1);
                continue;
            }
            sizeCount.add(sizeCount.get(i - 1) + disheses.get(i).getDishes().size() + 1);
        }
    }

    public int getCount() {
        return sizeCount.getLast();
    }

    public Object getItem(int position) {
        int at = findCurrentIndex(position);

        if (position - getPreItemSize(at) == 0) {
            return disheses.get(at).getName();
        } else {
            return disheses.get(at).getDishes().get(position - getPreItemSize(at) - 1);
        }
    }

    public long getItemId(int position) {
        return position;
    }

    public View getView(int position, View convertView, ViewGroup parent) {
        Object item = getItem(position);
        if (item instanceof Dish) {
            return new DishChoosingView(context, this, (Dish) item);
        } else {
            TextView headerView = new TextView(context);
            headerView.setPadding(context.getResources().getDimensionPixelSize(R.dimen.device_padding),
                    context.getResources().getDimensionPixelSize(R.dimen.vertical_padding),
                    context.getResources().getDimensionPixelSize(R.dimen.vertical_padding),
                    context.getResources().getDimensionPixelSize(R.dimen.device_padding));

            headerView.setText((String)item);
            headerView.setBackgroundResource(R.drawable.list_item_bg_rectangle);
            return headerView;
        }

    }

    public Map<Dish, Integer> getSelectedDishes() {
        return selectedDishes;

    }

    private int findCurrentIndex(int position) {
        for (int index = 0; index < sizeCount.size(); index++) {
            if (position + 1 <= sizeCount.get(index)) {
                 return index;
            }
        }
        return 0;
    }

    private Integer getPreItemSize(int at) {
        if (at == 0) {
            return 0;
        }
        return sizeCount.get(at - 1);
    }

}
