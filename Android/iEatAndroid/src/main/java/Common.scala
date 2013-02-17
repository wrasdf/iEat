package com.thoughtworks.ieat

import android.view.View
import android.view.View.OnClickListener

object Common {
  implicit def fun2OnClickListener(func: (View) => Unit) = {
    new OnClickListener {
      def onClick(v: View) {
        func(v)
      }
    }
  }
}
