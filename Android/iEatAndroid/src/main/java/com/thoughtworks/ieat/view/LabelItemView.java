package com.thoughtworks.ieat.view;

import android.content.Context;
import android.widget.TextView;
import com.thoughtworks.ieat.R;

public class LabelItemView extends TextView {

    public LabelItemView(Context context) {
        super(context);
        super.setBackgroundDrawable(getResources().getDrawable(R.drawable.list_item_bg));
        setPadding(15, 5, 0, 5);
        setClickable(false);
        setTextColor(R.color.black);
    }
}
