package com.thoughtworks.ieat.activity

import com.thoughtworks.ieat.Common._
import android.app.Activity
import android.os.Bundle
import android.widget.{Button, EditText}
import android.content.Intent
import android.view.View
import com.thoughtworks.ieat.R


class HelloAndroidActivity extends Activity {
  lazy val username = findViewById(R.id.username).asInstanceOf[EditText]
  lazy val password = findViewById(R.id.password).asInstanceOf[EditText]
  lazy val logInButton = findViewById(R.id.logInButton).asInstanceOf[Button]

  override def onCreate(savedInstanceState: Bundle) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.main)

    logInButton.setOnClickListener {
      (v: View) => {
        val intent = new Intent(HelloAndroidActivity.this, classOf[DashboardActivity])
        startActivity(intent)
      }
    }
  }
}

