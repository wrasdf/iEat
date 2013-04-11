package com.thoughtworks.ieat.view;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

public class EmptyAdapter extends BaseAdapter {
    private final Context context;
    private final String remindMessage;

    public EmptyAdapter(Context context, String remindMessage) {
        this.context = context;
        this.remindMessage = remindMessage;
    }

    public int getCount() {
        return 1;  //To change body of implemented methods use File | Settings | File Templates.
    }

    public Object getItem(int position) {
        return null;
    }

    public long getItemId(int position) {
        return 0;
    }

    public View getView(int i, View view, ViewGroup viewGroup) {
        LabelItemView emptyItemView = new LabelItemView(context);
        emptyItemView.setText(remindMessage);
        return emptyItemView;
    }
}
