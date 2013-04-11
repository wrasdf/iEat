package com.thoughtworks.ieat.view;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.domain.Group;

import java.util.List;

public class GroupsAdapter extends BaseAdapter {

    private final Context context;
    private final List<Group> groups;

    public GroupsAdapter(Context context, List<Group> groupList) {
        this.context = context;
        this.groups = groupList;
    }

    public int getCount() {
        return groups.size();
    }

    public Group getItem(int position) {
        return groups.get(position);
    }

    public long getItemId(int position) {
        return position;
    }

    public View getView(int position, View convertView, ViewGroup parent) {
        convertView = new GroupItemView(context, groups.get(position));
        if (getCount() == 1) {
            convertView.setBackgroundResource(R.drawable.list_item_bg);
        } else if (position == 0) {
            convertView.setBackgroundResource(R.drawable.list_item_bg_top);
        } else if (position == getCount() - 1) {
            convertView.setBackgroundResource(R.drawable.list_item_bg_bottom);
        } else {
            convertView.setBackgroundResource(R.drawable.list_item_bg_rectangle);
        }

        return convertView;
    }


}
