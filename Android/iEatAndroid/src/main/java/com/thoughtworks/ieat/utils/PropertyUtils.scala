package com.thoughtworks.ieat.activity.utils

import java.util.Properties
import android.R
import android.content.res.Resources

object PropertyUtils{
  var properties : Properties = null

  def init(mResources: Resources) {
    if (properties == null) {
      properties = new Properties()
      val appConfigProperties = mResources.openRawResource(com.thoughtworks.ieat.R.raw.app_config)
      try {
        properties.load(appConfigProperties)
      } catch {
        case e : IndexOutOfBoundsException => throw new RuntimeException(e)
      }
    }
  }

  def getServerHost() : String = {
    properties.getProperty("server.host")
  }

  def getServerPort() : Int =  {
    Integer.valueOf(properties.getProperty("server.port"))
  }
}