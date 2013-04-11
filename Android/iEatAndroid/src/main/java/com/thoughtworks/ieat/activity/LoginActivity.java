package com.thoughtworks.ieat.activity;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.graphics.Typeface;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.domain.AppHttpResponse;
import com.thoughtworks.ieat.domain.UserToken;
import com.thoughtworks.ieat.service.Server;

public class LoginActivity extends Activity {
    private EditText usernameView;
    private EditText passwordView;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.login);

        if (IEatApplication.currentUser() != null && IEatApplication.getToken() != null) {
            goToApp();
            finish();
            return;
        }

        usernameView = (EditText) findViewById(R.id.username);
        usernameView.setTypeface(Typeface.DEFAULT);
        passwordView = (EditText) findViewById(R.id.password);

        passwordView.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
                login(null);
                return false;
            }
        });
    }

    private void goToApp() {
        Intent intent = new Intent(this, GroupListActivity.class);
        startActivity(intent);
    }

    public void login(View view) {

        String username = usernameView.getText().toString();
        String pwd = passwordView.getText().toString();

        LoginAsyncTask loginTask = new LoginAsyncTask(this);
        loginTask.execute(username, pwd);
    }


    public class LoginAsyncTask extends AsyncTask<String, Void, AppHttpResponse<UserToken>> {

        private final Context context;
        private ProgressDialog loadingProgress;

        public LoginAsyncTask(Context context) {
            this.context = context;
        }

        public void onPreExecute() {
            loadingProgress = new ProgressDialog(context);
            loadingProgress.setMessage("login...");
            loadingProgress.setCanceledOnTouchOutside(false);
            loadingProgress.show();
        }

        public AppHttpResponse<UserToken> doInBackground(String... params) {
            AppHttpResponse appHttpResponse = Server.signIn(params[0], params[1]);
            return appHttpResponse;
        }

        public void onPostExecute(AppHttpResponse<UserToken> response) {
            loadingProgress.dismiss();
            if (response.isSuccessful()) {
                Intent intent = new Intent(context, GroupListActivity.class);
                startActivity(intent);
                finish();
            } else {
                Toast.makeText(context, response.getErrorMessage(), Toast.LENGTH_SHORT).show();
            }
        }
    }
}
