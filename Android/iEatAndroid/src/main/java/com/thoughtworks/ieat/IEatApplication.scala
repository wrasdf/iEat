package com.thoughtworks.ieat

import activity.utils.PropertyUtils
import utils.ApplicationData
import android.preference.PreferenceManager
import android.content.SharedPreferences

class IEatApplication extends android.app.Application{

  var isAuthenticated: Boolean = false

  override def onCreate() {
    PropertyUtils.init(this.getResources())
    val prefs : SharedPreferences = PreferenceManager.getDefaultSharedPreferences(getApplicationContext())
    ApplicationData.init(prefs)
  }

  def login(username : String) {
    isAuthenticated = true
    ApplicationData.setUsername(username)
  }

  def logout() {
    isAuthenticated = false
  }

}
