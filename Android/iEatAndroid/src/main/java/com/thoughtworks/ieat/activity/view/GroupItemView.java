package com.thoughtworks.ieat.activity.view;

import android.content.Context;
import android.view.LayoutInflater;
import android.widget.LinearLayout;
import android.widget.TextView;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.domain.Group;

public class GroupItemView extends LinearLayout {

    public GroupItemView(Context context) {
        super(context);
        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        inflater.inflate(R.layout.group_item, this);
    }

    public GroupItemView(Context context, Group group) {
        super(context);
        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        inflater.inflate(R.layout.group_item, this);

        addGroup(group);
    }

    public void addGroup(Group myGroup) {
        TextView groupNameView = (TextView) findViewById(R.id.group_name);
        groupNameView.setText(myGroup.getName());

        TextView groupOwerView = (TextView) findViewById(R.id.group_owner);
        groupOwerView.setText(myGroup.getOwner());

    }
}
