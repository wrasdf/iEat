package com.thoughtworks.ieat.utils;

import android.content.res.Resources;
import com.thoughtworks.ieat.R;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class PropertyUtils {
    private static Properties properties = null;

    public static void init(Resources mResources) {
        if (properties == null) {
            properties = new Properties();
            InputStream appConfigProperties = mResources.openRawResource(R.raw.app_config);
            try {
                properties.load(appConfigProperties);
            } catch (IndexOutOfBoundsException e) {
                throw new RuntimeException(e);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public static String getServerHost() {
        return properties.getProperty("server.host");
    }

    public static int getServerPort() {
        return Integer.valueOf(properties.getProperty("server.port"));
    }
}