package com.thoughtworks.ieat.activity

import android.app._
import android.os.Bundle
import android.view.View
import com.thoughtworks.ieat.R
import com.thoughtworks.ieat.Common._
import android.content.Intent

class DashboardActivity extends Activity {
  lazy val myGroupButton = findViewById(R.id.myGroup)
  lazy val addGroupButton = findViewById(R.id.addGroup)

  lazy val joinedGroupButton = findViewById(R.id.joinedGroup)
  lazy val joinAnotherGroupButton = findViewById(R.id.joinAnotherGroup)

  override def onCreate(savedInstanceState: Bundle) {
    super.onCreate(savedInstanceState)

    setContentView(R.layout.dashboard)

    myGroupButton.setOnClickListener { (v: View) => startActivity(new Intent(DashboardActivity.this, classOf[MyGroupActivity])) }
    addGroupButton.setOnClickListener { (v: View) => startActivity(new Intent(DashboardActivity.this, classOf[MyGroupActivity])) }
    joinedGroupButton.setOnClickListener { (v: View) => startActivity(new Intent(DashboardActivity.this, classOf[JoinedGroupActivity])) }
    joinAnotherGroupButton.setOnClickListener { (v: View) => startActivity(new Intent(DashboardActivity.this, classOf[JoinedGroupActivity]))}
  }
}

