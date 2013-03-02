package com.thoughtworks.ieat.activity.view;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import com.thoughtworks.ieat.domain.Group;

import java.util.List;

public class GroupsAdapter extends BaseAdapter {

    private final Context context;
    private final List<Group> groups;
    private final LayoutInflater layoutInflater;

    public GroupsAdapter(Context context, List<Group> groupList) {
        this.context = context;
        this.groups = groupList;
        layoutInflater = LayoutInflater.from(context);
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
        return convertView;
    }


}
