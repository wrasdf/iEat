package com.thoughtworks.ieat

import android.app.Activity;
import android.os.Bundle;

class HelloAndroidActivity extends Activity {
  override def onCreate(savedInstanceState: Bundle) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.main)
  }
}

