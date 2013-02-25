package com.thoughtworks.ieat.utils

import android.content.SharedPreferences
import android.content.SharedPreferences.Editor

object ApplicationData {

  var sharedPreferences : SharedPreferences = null

  def init(preferences: SharedPreferences) {
    sharedPreferences = preferences
  }

  def setUsername(username : String) {
    try {
      val edit: Editor = sharedPreferences.edit()
      edit.putString("CURRENT_USER_NAME", username)
      edit.commit()
    }
    catch {
      case e : Exception => {
        throw new RuntimeException(e)
      }
    }
  }

  def getCurrentUser() : String = {
    return sharedPreferences.getString("CURRENT_USER_NAME", null)
  }
}
