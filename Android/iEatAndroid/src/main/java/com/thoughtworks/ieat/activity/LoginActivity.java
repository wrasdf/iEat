package com.thoughtworks.ieat.activity;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.utils.HttpUtils;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;

public class LoginActivity extends Activity {
    private EditText usernameView;
    private EditText passwordView;
    private Button logInButton;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.login);

        usernameView = (EditText) findViewById(R.id.username);
        passwordView = (EditText) findViewById(R.id.password);
        logInButton = (Button) findViewById(R.id.logInButton);

        passwordView.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
                login(null);
                return false;
            }
        });
    }

    public void login(View view) {

        String username = usernameView.getText().toString();
        String pwd = passwordView.getText().toString();

        LoginAsyncTask loginTask = new LoginAsyncTask(this);
        loginTask.execute(username, pwd);


    }


    public class LoginAsyncTask extends AsyncTask<String, Void, Integer> {

        private final Context context;
        private ProgressDialog loadingProgress;
        private String username;

        public LoginAsyncTask(Context context) {
            this.context = context;
        }

        public void onPreExecute() {
            loadingProgress = new ProgressDialog(context);
            loadingProgress.setMessage("login...");
            loadingProgress.setCanceledOnTouchOutside(false);
            loadingProgress.show();
        }

        public Integer doInBackground(String... params) {
            try {
                HttpResponse response = HttpUtils.login(params[0], params[1]);
                HttpUtils.login(params[0], params[1]);
                username = params[0];
                return response.getStatusLine().getStatusCode();
            } catch (RuntimeException exception) {
                Log.e(this.getClass().getName(), exception.getMessage(), exception);
            }
            return null;

        }

        public void onPostExecute(Integer responseStatus) {
            loadingProgress.dismiss();
            if (responseStatus == null) {
                Toast.makeText(context, "login failed", Toast.LENGTH_SHORT).show();
                return;
            }
            if (HttpStatus.SC_OK == responseStatus) {
                ((IEatApplication) getApplication()).login(username);
                Intent intent = new Intent(context, GroupListActivity.class);
                startActivity(intent);
            } else {
                Toast.makeText(context, responseStatus.toString(), Toast.LENGTH_SHORT).show();
            }
        }
    }
}
