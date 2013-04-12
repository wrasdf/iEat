package com.thoughtworks.ieat.activity;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.method.LinkMovementMethod;
import android.text.style.ClickableSpan;
import android.view.View;
import android.view.Window;
import android.widget.TextView;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.R;
import com.thoughtworks.ieat.domain.Group;

public class GroupInfoActivity extends ActionBarActivity {


    private Group group;

    @Override
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.group_info);

        group = (Group) getIntent().getExtras().get(IEatApplication.EXTRA_GROUP);

        ((TextView) findViewById(R.id.group_info_name)).setText(group.getName());
        ((TextView) findViewById(R.id.group_info_owner_name)).setText(group.getOwner().getName());


        ((TextView) findViewById(R.id.group_info_restaurant_name)).setText(group.getRestaurant().getName());
        TextView telephoneView = (TextView) findViewById(R.id.group_info_restaurant_telephone);
        setTelephone(telephoneView);
        ((TextView) findViewById(R.id.group_info_restaurant_address)).setText(group.getRestaurant().getAddress());
    }

    @Override
    public void onResume() {
        super.onResume();
    }

    private void setTelephone(TextView telephoneView) {
        String telephone = group.getRestaurant().getTelephone();
        if (telephone == null || telephone.isEmpty() || "NO VALUE".equals(telephone.trim())) {
            telephoneView.setText(R.string.group_info_telephone_empty);
        } else {
            SpannableString spannableString = new SpannableString(telephone);
            PhoneClickableSpan phoneClickableSpan = new PhoneClickableSpan(telephone);
            spannableString.setSpan(phoneClickableSpan, 0, telephone.length(), Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
            telephoneView.setText(spannableString);
            telephoneView.setMovementMethod(LinkMovementMethod.getInstance());
        }
    }

    protected class PhoneClickableSpan extends ClickableSpan {

        private String phoneNumber;

        public PhoneClickableSpan(String phoneNumber) {
            this.phoneNumber = phoneNumber.replace(" ", "");
        }

        @Override
        public void onClick(View widget) {
            Intent callIntent = new Intent(Intent.ACTION_DIAL);
            callIntent.setData(Uri.parse("tel:" + phoneNumber));
            GroupInfoActivity.this.startActivity(callIntent);
        }

//        @Override
//        public void updateDrawState(TextPaint textPaint) {
//            textPaint.setColor(getPaint());
//            textPaint.setLinearText(false);
//        }

    }

}
