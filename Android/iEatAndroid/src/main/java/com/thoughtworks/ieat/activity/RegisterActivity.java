package com.thoughtworks.ieat.activity;

import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.domain.AppHttpResponse;
import com.thoughtworks.ieat.domain.User;
import com.thoughtworks.ieat.service.Server;

import java.util.HashMap;
import java.util.Map;

public class RegisterActivity extends ActionBarActivity {

    private EditText usernameView;
    private EditText emailView;
    private EditText phoneNumberView;
    private EditText passwordView;
    private EditText passwordConfirmView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.register);

        usernameView = (EditText) findViewById(R.id.register_username);
        emailView = (EditText) findViewById(R.id.register_email);
        phoneNumberView = (EditText) findViewById(R.id.register_phone_number);
        passwordView = (EditText) findViewById(R.id.register_password);
        passwordConfirmView = (EditText) findViewById(R.id.register_password_confirm);

        setTitle(R.string.register_title);
        getActionBar().setDisplayHomeAsUpEnabled(true);
    }

    public void register(View view) {
        if (hasInvalidInput()) return;

        HashMap<String, String> registerInformation = new HashMap<String, String>();
        registerInformation.put("name", usernameView.getText().toString());
        registerInformation.put("email", emailView.getText().toString());
        registerInformation.put("telephone", phoneNumberView.getText().toString());
        registerInformation.put("password", passwordView.getText().toString());
        registerInformation.put("password_confirmation", passwordConfirmView.getText().toString());

        new RegisterAsyncTask(this).execute(registerInformation);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case android.R.id.home:
            case R.id.actionbar_home_button:
                goToLogin();
                break;
        }
        return false;
    }

    private void goToLogin() {
        Intent intent = new Intent(this, LoginActivity.class);
        startActivity(intent);
    }

    private boolean hasInvalidInput() {
        if (toastEmptyMessage(usernameView, R.string.register_username_lable)) return true;
        if (toastEmptyMessage(emailView, R.string.register_email_label)) return true;
        if (toastEmptyMessage(phoneNumberView, R.string.register_phone_number_label)) return true;
        if (toastEmptyMessage(passwordView, R.string.register_password_label)) return true;
        if (toastEmptyMessage(passwordConfirmView, R.string.register_password_confirm_label)) return true;

        if (!passwordView.getText().toString().equals(passwordConfirmView.getText().toString())) {
            Toast.makeText(this, getString(R.string.register_password_not_same_message), Toast.LENGTH_SHORT);
            return true;
        }
        return false;
    }

    private boolean toastEmptyMessage(EditText editView, int viewLabelId) {
        if (editView.getText().toString().equals("")) {
            Toast.makeText(this, getString(viewLabelId) + getString(R.string.input_empty_message), Toast.LENGTH_SHORT).show();
            return true;
        }
        return false;
    }

    private class RegisterAsyncTask extends AsyncTask<Map<String, String>, Void, AppHttpResponse<User>> {

        private final Context context;
        private ProgressDialog loadingProgress;

        public RegisterAsyncTask(Context context) {
            this.context = context;
        }

        @Override
        protected void onPreExecute() {
            loadingProgress = new ProgressDialog(context);
            loadingProgress.setMessage("login...");
            loadingProgress.setCanceledOnTouchOutside(false);
            loadingProgress.show();
        }

        @Override
        protected AppHttpResponse<User> doInBackground(Map<String, String>... params) {
            return Server.signUp(params[0]);
        }

        @Override
        protected void onPostExecute(AppHttpResponse<User> userAppHttpResponse) {
            loadingProgress.dismiss();
            if (userAppHttpResponse.isSuccessful()) {
                Toast.makeText(context, "successful", Toast.LENGTH_SHORT);
                Intent intent = new Intent(context, GroupListActivity.class);
                context.startActivity(intent);
            } else {
                Toast.makeText(context, userAppHttpResponse.getErrorMessage(), Toast.LENGTH_SHORT);
            }

        }
    }
}