package com.thoughtworks.ieat.utils;

import com.google.gson.*;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.domain.AppHttpResponse;
import com.thoughtworks.ieat.domain.Group;
import de.akquinet.android.androlog.Log;
import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.conn.SingleClientConnManager;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpParams;
import org.apache.http.protocol.HTTP;

import java.io.IOException;
import java.lang.reflect.Type;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class HttpUtils {

    private static HttpClient httpClient;
    private static HttpHost httpHost;


    public static <E> AppHttpResponse<E> get(String url, Class<E> responseClass) throws IOException {
        HttpGet httpGet = new HttpGet(url + "?token=" + IEatApplication.getToken());
        httpGet.setHeader("Accept", "application/json");
        HttpResponse response = getHttpClient().execute(getHttpHost(), httpGet);
        return parseResponse(response, responseClass);
    }

    public static <E> AppHttpResponse<E> get(String url, Type type) throws IOException {
        HttpGet httpGet = new HttpGet(url + "?token=" + IEatApplication.getToken());
        httpGet.setHeader("Accept", "application/json");
        HttpResponse response= getHttpClient().execute(getHttpHost(), httpGet);
        return parseResponse(response, type);
    }

    public static boolean get(String url) throws IOException {
        HttpGet httpGet = new HttpGet(url + "?token=" + IEatApplication.getToken());
        httpGet.setHeader("Accept", "application/json");
        HttpResponse response= getHttpClient().execute(getHttpHost(), httpGet);
        return response.getStatusLine().getStatusCode() == HttpStatus.SC_OK;
    }

    public static <T> AppHttpResponse<T> post(String url, Map<String, String> postParams, Class<T> responseClass) throws IOException {
        String postJson = new Gson().toJson(postParams);
        return post(url, postJson, responseClass);
    }

    public static <E> AppHttpResponse<E> post(String url, String postJsonData, Class<E> responseClass) throws IOException {
        HttpPost httpPost = new HttpPost(url + "?token=" + IEatApplication.getToken());
        StringEntity entity = new StringEntity(postJsonData, HTTP.UTF_8);
        httpPost.setEntity(entity);
        httpPost.setHeader("Accept", "application/json");
        httpPost.setHeader("Content-type", "application/json");
        httpPost.addHeader("charset", HTTP.UTF_8);

        HttpResponse response = getHttpClient().execute(getHttpHost(), httpPost);
        AppHttpResponse<E> appHttpResponse = parseResponse(response, responseClass);
        return appHttpResponse;
    }

    private static <E> AppHttpResponse<E> parseResponse(HttpResponse response, Class<E> responseClass) throws IOException {
        AppHttpResponse<E> appHttpResponse = new AppHttpResponse<E>();
        if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
            String json = IOUtils.toString(response.getEntity().getContent());
            Log.d("HTTP response", json);
            Gson gson = new GsonBuilder().registerTypeAdapter(Date.class, new DateJsonDeserializer()).create();
            E responseData = gson.fromJson(json, responseClass);
            appHttpResponse.setData(responseData);
        } else {
            appHttpResponse.setErrorMessage(String.valueOf(response.getStatusLine().getStatusCode()));
        }
        return appHttpResponse;
    }

    private static class DateJsonDeserializer implements JsonDeserializer<Date> {

        public Date deserialize(JsonElement jsonElement, Type type, JsonDeserializationContext jsonDeserializationContext) throws JsonParseException {
            String dateStr = jsonElement.getAsString();
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat();
            simpleDateFormat.applyPattern(IEatApplication.DATE_PATTERN);
            simpleDateFormat.setTimeZone(TimeZone.getTimeZone("GMT+00:00"));
            try {
                return simpleDateFormat.parse(dateStr);
            } catch (ParseException e) {
                throw new JsonParseException(e);
            }
        }
    }

    private static <E> AppHttpResponse<E> parseResponse(HttpResponse response, Type type) throws IOException {
        AppHttpResponse<E> appHttpResponse = new AppHttpResponse<E>();
        if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
            String json = IOUtils.toString(response.getEntity().getContent());
            Log.d("HTTP response", json);
            Gson gson = new GsonBuilder().registerTypeAdapter(Date.class, new DateJsonDeserializer()).create();
            E responseData = gson.fromJson(json, type);
            appHttpResponse.setData(responseData);
        } else {
            appHttpResponse.setErrorMessage(String.valueOf(response.getStatusLine().getStatusCode()));
        }
        return appHttpResponse;
    }

    private static HttpClient getHttpClient() {
        if (httpClient == null) {
            httpClient = new DefaultHttpClient();
        }
        return httpClient;
    }

    private static HttpHost getHttpHost() {
        if (httpHost == null) {
            httpHost = new HttpHost(PropertyUtils.getServerHost(), PropertyUtils.getServerPort());
        }
        return httpHost;
    }
}
