package com.thoughtworks.ieat.activity

import android.app.ListActivity
import android.os.Bundle
import android.widget._
import android.content.Context
import com.thoughtworks.ieat.model._
import android.view.{LayoutInflater, ViewGroup, View}
import com.thoughtworks.ieat.R
import com.thoughtworks.ieat.model.Group
import com.thoughtworks.ieat.model.User

class MyGroupActivity extends ListActivity {

  override def onCreate(savedInstanceState: Bundle) = {
    super.onCreate(savedInstanceState)

    val groupList = List(Group("group1", User("Beany", "mxzou@thoughtworks.com")), Group("group2", User("Ao", "aozhu@thougtworks.com")))
    this.setListAdapter(new GroupAdapter(this, groupList))
  }
}

class JoinedGroupActivity extends ListActivity {

  override def onCreate(savedInstanceState: Bundle) = {
    super.onCreate(savedInstanceState)

    val groupList = List(Group("group3", User("Beany", "mxzou@thoughtworks.com")), Group("group4", User("Ao", "aozhu@thougtworks.com")))
    this.setListAdapter(new GroupAdapter(this, groupList))
  }
}

class GroupAdapter(val context: Context, val groupList: List[Group]) extends BaseAdapter {
  def getCount: Int = groupList.size

  def getItem(position: Int): Group = groupList(position)

  def getItemId(position: Int): Long = position

  def getView(position: Int, convertView: View, parent: ViewGroup): View = {
    val groupItem = if (convertView == null) {
      new GroupItem(context)
    } else {
      convertView.asInstanceOf[GroupItem]
    }

    groupItem.data(getItem(position))

    groupItem
  }
}

class GroupItem(context: Context) extends LinearLayout(context) {
  lazy val mInflater = LayoutInflater.from(context)
  this.addView(mInflater.inflate(R.layout.group_item, this, false))

  lazy val groupName = findViewById(R.id.group_name).asInstanceOf[TextView]
  lazy val groupOwner = findViewById(R.id.group_owner).asInstanceOf[TextView]

  def data(group: Group) {
    groupName.setText(group.name)
    groupOwner.setText(group.owner.name)
  }
}