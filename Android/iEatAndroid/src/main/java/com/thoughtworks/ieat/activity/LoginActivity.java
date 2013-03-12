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
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.domain.AppHttpResponse;
import com.thoughtworks.ieat.domain.UserToken;
import com.thoughtworks.ieat.utils.HttpUtils;

public class LoginActivity extends Activity {
    private EditText usernameView;
    private EditText passwordView;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.login);

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

    public void login(View view) {

        String username = usernameView.getText().toString();
        String pwd = passwordView.getText().toString();

        LoginAsyncTask loginTask = new LoginAsyncTask(this);
        loginTask.execute(username, pwd);


    }


    public class LoginAsyncTask extends AsyncTask<String, Void, AppHttpResponse<UserToken>> {

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

        public AppHttpResponse<UserToken> doInBackground(String... params) {
            AppHttpResponse appHttpResponse = HttpUtils.signIn(params[0], params[1]);
            username = params[0];
            return appHttpResponse;
        }

        public void onPostExecute(AppHttpResponse<UserToken> response) {
            loadingProgress.dismiss();
            if (response.isSuccessful()) {
                ((IEatApplication) getApplication()).login(username);
                Intent intent = new Intent(context, GroupListActivity.class);
                startActivity(intent);
            } else {
                Toast.makeText(context, response.getErrorMessage(), Toast.LENGTH_SHORT).show();
            }
        }
    }
}
