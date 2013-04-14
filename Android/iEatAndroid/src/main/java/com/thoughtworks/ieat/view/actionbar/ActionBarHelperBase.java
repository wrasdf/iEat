/*
 * Copyright 2011 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.thoughtworks.ieat.view.actionbar;

import android.app.Activity;
import android.content.Context;
import android.content.res.XmlResourceParser;
import android.os.Bundle;
import android.view.*;
import android.widget.*;
import com.thoughtworks.ieat.R;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

/**
 * A class that implements the action bar pattern for pre-Honeycomb devices.
 */
public class ActionBarHelperBase extends ActionBarHelper {
    private static final String MENU_RES_NAMESPACE = "http://schemas.android.com/apk/res/android";
    private static final String MENU_ATTR_ID = "id";
    private static final String MENU_ATTR_SHOW_AS_ACTION = "showAsAction";
    
    
    private TextView titleView;

    protected Set<Integer> mActionItemIds = new HashSet<Integer>();

    protected ActionBarHelperBase(Activity activity) {
        super(activity);
    }

    /**{@inheritDoc}*/
    @Override
    public void onCreate(Bundle savedInstanceState) {
    	mActivity.requestWindowFeature(Window.FEATURE_CUSTOM_TITLE);
    }

    /**{@inheritDoc}*/
    @Override
    public void onPostCreate(Bundle savedInstanceState) {
        mActivity.getWindow().setFeatureInt(Window.FEATURE_CUSTOM_TITLE,
                R.layout.actionbar_compat);
        setupActionBar();

        SimpleMenu menu = new SimpleMenu(mActivity);
        mActivity.onCreatePanelMenu(Window.FEATURE_OPTIONS_PANEL, menu);
        mActivity.onPrepareOptionsMenu(menu);
        for (int i = 0; i < menu.size(); i++) {
            MenuItem item = menu.getItem(i);
            if (mActionItemIds.contains(item.getItemId())) {
                addActionItemCompatFromMenuItem(item);
            }
        }
    }

    /**
     * Sets up the compatibility action bar with the given title.
     */
    private void setupActionBar() {
        final ViewGroup actionBarCompat = getActionBarCompat();
        if (actionBarCompat == null) {
            return;
        }

/*        LinearLayout.LayoutParams springLayoutParams = new LinearLayout.LayoutParams(
                0, ViewGroup.LayoutParams.FILL_PARENT);
        springLayoutParams.weight = 1;
*/        
//        Add Home button
//        SimpleMenu tempMenu = new SimpleMenu(mActivity);
//        SimpleMenuItem homeItem = new SimpleMenuItem(
//                tempMenu, R.id.actionbar_home_button, 0, "");
//        homeItem.setIcon(R.drawable.icon);
//        addActionItemCompatFromMenuItem(homeItem);

        // Add title text
/*        TextView titleText = new TextView(mActivity, null, R.attr.actionbarCompatTitleStyle);
//        titleText.setLayoutParams(springLayoutParams);
        titleText.setText(mActivity.getTitle());
        actionBarCompat.addView(titleText); */
/*        
        SimpleMenuItem settingsMenu = new SimpleMenuItem(tempMenu, R.id.action_bar_settings, 1, "");
        settingsMenu.setIcon(R.drawable.menu_settings);
        addActionItemCompatFromMenuItem(settingsMenu);
*/    }

    /**{@inheritDoc}*/
    @Override
    public void setRefreshActionItemState(boolean refreshing) {
        View refreshButton = mActivity.findViewById(R.id.actionbar_compat_item_refresh);

        View refreshIndicator = mActivity.findViewById(
                R.id.actionbar_compat_item_refresh_progress);

        if (refreshButton != null) {
            refreshButton.setVisibility(refreshing ? View.GONE : View.VISIBLE);
        }
        if (refreshIndicator != null) {
            refreshIndicator.setVisibility(refreshing ? View.VISIBLE : View.GONE);
        }
    }

    /**
     * Action bar helper code to be run in {@link android.app.Activity#onCreateOptionsMenu(android.view.Menu)}.
     *
     * NOTE: This code will mark on-screen menu items as invisible.
     */
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Hides on-screen action items from the options menu.
        for (Integer id : mActionItemIds) {
            menu.findItem(id).setVisible(false);
        }
        return true;
    }

    /**{@inheritDoc}*/
    @Override
    public void onTitleChanged(CharSequence title, int color) {
        titleView = (TextView) mActivity.findViewById(R.id.headerTitle);
        if (titleView != null){
            titleView.setText(title);
        }
    }

    /**
     * Returns a {@link android.view.MenuInflater} that can read action bar metadata on
     * pre-Honeycomb devices.
     */
    public MenuInflater getMenuInflater(MenuInflater superMenuInflater) {
        return new WrappedMenuInflater(mActivity, superMenuInflater);
    }

    /**
     * Returns the {@link android.view.ViewGroup} for the action bar on phones (compatibility action
     * bar). Can return null, and will return null on Honeycomb.
     */
    private ViewGroup getActionBarCompat() {
        return (ViewGroup) mActivity.findViewById(R.id.actionbar_compat);
    }

    /**
     * Adds an action button to the compatibility action bar, using menu information from a {@link
     * android.view.MenuItem}. If the menu item ID is <code>menu_refresh</code>, the menu item's
     * state can be changed to show a loading spinner using
     */
    private View addActionItemCompatFromMenuItem(final MenuItem item) {
        final int itemId = item.getItemId();

        //final ViewGroup actionBar = getActionBarCompat();
      final ViewGroup actionBar = getActionBarCompat();
        if (actionBar == null) {
            return null;
        }
        
        LinearLayout buttonsLayout = (LinearLayout) actionBar.findViewById( R.id.actionbar_compat_buttonsLayout );

        if( buttonsLayout == null ) {
            return null;
        }
        
        // Create the button
        Button actionButton = new Button(mActivity, null, R.attr.actionbarCompatItemStyle);
        LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
                (int) mActivity.getResources().getDimension(R.dimen.actionbar_compat_button_width),
                ViewGroup.LayoutParams.FILL_PARENT);

        actionButton.setLayoutParams(layoutParams);
        actionButton.setId(itemId);

        if (itemId == R.id.actionbar_home_button) {
        	actionButton.setId(R.id.actionbar_home_button_imageId);
        }
        else if (itemId == R.id.menu_refresh) {
        	actionButton.setId(R.id.actionbar_compat_item_refresh);
        }

        actionButton.setText(item.getTitle());
        actionButton.setGravity(Gravity.CENTER_VERTICAL);
        actionButton.setTextSize(13);

        actionButton.setPadding(0, 2, 0, 2);
        actionButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View view) {
                mActivity.onMenuItemSelected(Window.FEATURE_OPTIONS_PANEL, item);
            }
        });

        if( itemId == R.id.actionbar_home_button ) {
            actionBar.addView(actionButton);
        }
        else {
            buttonsLayout.addView(actionButton);
        }

        if (item.getItemId() == R.id.menu_refresh) {
            // Refresh buttons should be stateful, and allow for indeterminate progress indicators,
            // so add those.
            ProgressBar indicator = new ProgressBar(mActivity, null,
                    R.attr.actionbarCompatProgressIndicatorStyle);

            final int buttonWidth = mActivity.getResources().getDimensionPixelSize(
                    R.dimen.actionbar_compat_button_width);
            final int buttonHeight = mActivity.getResources().getDimensionPixelSize(
                    R.dimen.actionbar_compat_height);
            final int progressIndicatorWidth = buttonWidth / 2;

            LinearLayout.LayoutParams progressIndicatorParams = new LinearLayout.LayoutParams(progressIndicatorWidth, progressIndicatorWidth);
            progressIndicatorParams.setMargins(
                    (buttonWidth - progressIndicatorWidth) / 2,
                    (buttonHeight - progressIndicatorWidth) / 2,
                    (buttonWidth - progressIndicatorWidth) / 2,
                    0);
            indicator.setLayoutParams(progressIndicatorParams);

            indicator.setVisibility(View.GONE);
            indicator.setId(R.id.actionbar_compat_item_refresh_progress);

            buttonsLayout.addView(indicator);
        }

        return actionButton;
    }

    /**
     * A {@link android.view.MenuInflater} that reads action bar metadata.
     */
    private class WrappedMenuInflater extends MenuInflater {
        MenuInflater mInflater;

        public WrappedMenuInflater(Context context, MenuInflater inflater) {
            super(context);
            mInflater = inflater;
        }

        @Override
        public void inflate(int menuRes, Menu menu) {
            loadActionBarMetadata(menuRes);
            mInflater.inflate(menuRes, menu);
        }

        /**
         * Loads action bar metadata from a menu resource, storing a list of menu item IDs that
         * should be shown on-screen (i.e. those with showAsAction set to always or ifRoom).
         * @param menuResId
         */
        private void loadActionBarMetadata(int menuResId) {
            XmlResourceParser parser = null;
            try {
                parser = mActivity.getResources().getXml(menuResId);

                int eventType = parser.getEventType();
                int itemId;
                int showAsAction;

                boolean eof = false;
                while (!eof) {
                    switch (eventType) {
                        case XmlPullParser.START_TAG:
                            if (!parser.getName().equals("item")) {
                                break;
                            }

                            itemId = parser.getAttributeResourceValue(MENU_RES_NAMESPACE,
                                    MENU_ATTR_ID, 0);
                            if (itemId == 0) {
                                break;
                            }

                            showAsAction = parser.getAttributeIntValue(MENU_RES_NAMESPACE,
                                    MENU_ATTR_SHOW_AS_ACTION, -1);
                            if (showAsAction == MenuItem.SHOW_AS_ACTION_ALWAYS ||
                                    showAsAction == MenuItem.SHOW_AS_ACTION_IF_ROOM) {

                                mActionItemIds.add(itemId);
                            }
                            break;

                        case XmlPullParser.END_DOCUMENT:
                            eof = true;
                            break;
                    }

                    eventType = parser.next();
                }
            } catch (XmlPullParserException e) {
                throw new InflateException("Error inflating menu XML", e);
            } catch (IOException e) {
                throw new InflateException("Error inflating menu XML", e);
            } finally {
                if (parser != null) {
                    parser.close();
                }
            }
        }

    }

	@Override
	public void setActionBarTheme(int color, int logoResId)
	{
		if (titleView != null) {
			titleView.setTextColor(color);
		
			String text = titleView.getText().toString();
			
			if( text != null ) {
			    titleView.setContentDescription( text );
			}
		}
		
		if (getActionBarCompat() != null)
		{
			ImageButton actionButton = (ImageButton)getActionBarCompat().findViewById(R.id.actionbar_home_button_imageId);
			actionButton.setImageResource(logoResId);
		}
	}
	
	@Override
	public void hideIcons() {
	    ViewGroup actionBar = getActionBarCompat();
        
        if( actionBar != null ) {
                
            LinearLayout buttonsLayout = (LinearLayout) actionBar.findViewById( R.id.actionbar_compat_buttonsLayout );

            if( buttonsLayout != null ) {
                buttonsLayout.setVisibility(View.GONE);
            }
        }
	}
	
    @Override
    public void setActionBarSettingsIconTheme(int color, int logoResId)
	{
        ViewGroup actionBar = getActionBarCompat();
	         
        if( actionBar != null ) {
	            
            LinearLayout buttonsLayout = (LinearLayout) actionBar.findViewById( R.id.actionbar_compat_buttonsLayout );

            if( buttonsLayout != null ) {

                int count = buttonsLayout.getChildCount();
    	                        
                for( int i = 0; i < count; i++ ) {
    	            
                    ImageButton button = (ImageButton)buttonsLayout.getChildAt( i );
        	            
                    if( button != null ) {
    	                             
                        button.setImageResource(logoResId);
                    }
                }
            }
        }
	}

    @Override
    public void setDisplayHomeAsUpEnabled(boolean show) {
        if (show) {
//            SimpleMenu tempMenu = new SimpleMenu(mActivity);
            final SimpleMenuItem homeItem = new SimpleMenuItem(
                    null, R.id.actionbar_home_button, 0, "");
            getActionBarCompat().findViewById(R.id.actionbar_home_button).setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {

                    mActivity.onOptionsItemSelected(homeItem);
                }
            });
            getActionBarCompat().findViewById(R.id.up_indicator).setVisibility(View.VISIBLE);
        } else {
            getActionBarCompat().findViewById(R.id.up_indicator).setVisibility(View.GONE);
        }
    }
}
