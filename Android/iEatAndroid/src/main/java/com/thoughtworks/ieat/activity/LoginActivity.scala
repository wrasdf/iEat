package com.thoughtworks.ieat.activity

import com.thoughtworks.ieat.Common._
import android.app.{ProgressDialog, Activity}
import android.os.{AsyncTask, Bundle}
import android.widget.{Toast, Button, EditText}
import android.content.{Context, Intent}
import android.view.View
import com.thoughtworks.ieat.{IEatApplication, activity, R}
import android.text.{Editable, TextWatcher}
import org.apache.http.client.methods.HttpPost
import org.apache.http.params.{BasicHttpParams, DefaultedHttpParams}
import org.apache.http.impl.client.DefaultHttpClient
import org.apache.http.{HttpStatus, HttpHost}
import com.thoughtworks.ieat.activity.utils.PropertyUtils
import android.view.View.OnFocusChangeListener
import scala.Array


class LoginActivity extends Activity {
  lazy val username = findViewById(R.id.username).asInstanceOf[EditText]
  lazy val password = findViewById(R.id.password).asInstanceOf[EditText]
  lazy val logInButton = findViewById(R.id.logInButton).asInstanceOf[Button]

  override def onCreate(savedInstanceState: Bundle) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.login)

//    logInButton.setOnClickListener {
//      (v: View) => {
//        val intent = new Intent(LoginActivity.this, classOf[DashboardActivity])
//        startActivity(intent)
//      }
//    }

    username.setOnFocusChangeListener(new OnFocusChangeListener {
      def onFocusChange(v: View, hasFocus: Boolean) {
        if (!hasFocus) {
          isCheckValidUsername(v.asInstanceOf[EditText].getText.toString)
        }
      }
    })

  }

  def isCheckValidUsername(username: String) : Boolean = {
    if (!username.endsWith("@thoughtworks.com")) {
      Toast.makeText(LoginActivity.this, "please input thoughtworks mail!", Toast.LENGTH_SHORT).show()
      return false
    }
    return true
  }

  def login(view : View) {

    val param: Array[String] = new Array[String](2)
    param(0) = username.getText.toString
    param(1) =  password.getText.toString

    if (!isCheckValidUsername(param.apply(0))) {
      return
    }

//    val loginTask: LoginTask = new LoginTask(this, param.apply(0), param.apply(1))
//    loginTask.execute()

    val loadingProgress = new ProgressDialog(this)
    onPreExecute(loadingProgress);

    val responseStatus = doInBackground(username.getText.toString, password.getText.toString)

    loadingProgress.dismiss()
    if (responseStatus == HttpStatus.SC_OK) {
      this.getApplication.asInstanceOf[IEatApplication].login(param.apply(0));
      Toast.makeText(this, "send succuessful", Toast.LENGTH_SHORT).show()
      val intent = new Intent(this, classOf[DashboardActivity])
      this.startActivity(intent)
    } else {
      Toast.makeText(this, responseStatus.toString, Toast.LENGTH_SHORT).show()
    }

  }

  def onPreExecute(loadingProgress: ProgressDialog) {
    loadingProgress.setMessage("login...")
    loadingProgress.setCanceledOnTouchOutside(false)
    loadingProgress.show();
  }

  def doInBackground(username : String, password : String) : Int = {
    val httpHost = new HttpHost(PropertyUtils.getServerHost(), PropertyUtils.getServerPort())

    val httpPost = new HttpPost("/users/sign_in")
    val httpParams = new BasicHttpParams()
    httpParams.setParameter("email", username)
    httpParams.setParameter("password", password)
    val httpClient = new DefaultHttpClient()
    httpClient.setParams(httpParams)
    try {
      val response = httpClient.execute(httpHost, httpPost)
      return response.getStatusLine.getStatusCode.toInt
    } catch {
      case exception: Exception => {
        Toast.makeText(this, exception.getMessage, Toast.LENGTH_SHORT).show()
        return 0.toInt
      }

    }

  }


}

class LoginTask(context: Context, username : String, password : String) extends AsyncTask[Void, Void, Int] {
  val loadingProgress = new ProgressDialog(context)

  override def onPreExecute() {
    loadingProgress.setMessage("login...")
    loadingProgress.setCanceledOnTouchOutside(false)
    loadingProgress.show();
  }

  override def doInBackground(p : Void*) : Int = {
    val httpHost = new HttpHost(PropertyUtils.getServerHost(), PropertyUtils.getServerPort())

    val httpPost = new HttpPost("/users/sign_in")
    val httpParams = new BasicHttpParams()
    httpParams.setParameter("email", username)
    httpParams.setParameter("password", password)
    val httpClient = new DefaultHttpClient()
    httpClient.setParams(httpParams)
    try {
      val response = httpClient.execute(httpHost, httpPost)
      return response.getStatusLine.getStatusCode.toInt
    } catch {
      case exception: Exception => {
        Toast.makeText(context, exception.getMessage, Toast.LENGTH_SHORT).show()
        return 0.toInt
      }

    }

  }

  override def onPostExecute(responseStatus : Int) {
    if (responseStatus == HttpStatus.SC_OK) {
      Toast.makeText(context, "send succuessful", Toast.LENGTH_SHORT).show()
      val intent = new Intent(context, classOf[DashboardActivity])
      context.startActivity(intent)
    } else {
      Toast.makeText(context, responseStatus.toString, Toast.LENGTH_SHORT).show()
    }
  }

}

