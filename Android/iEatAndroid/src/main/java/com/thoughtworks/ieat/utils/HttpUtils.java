package com.thoughtworks.ieat.utils;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
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
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;

import java.io.IOException;
import java.lang.reflect.Type;
import java.util.LinkedList;
import java.util.Map;

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

    public static <T> AppHttpResponse<T> post(String url, Map<String, String> postParams, Class<T> responseClass) throws IOException {
        HttpPost httpPost = new HttpPost(url + "?token=" + IEatApplication.getToken());
        LinkedList<BasicNameValuePair> basicNameValuePairLinkedList = new LinkedList<BasicNameValuePair>();
        for (Map.Entry<String, String> param : postParams.entrySet()) {
            basicNameValuePairLinkedList.add(new BasicNameValuePair(param.getKey(), param.getValue()));
        }
        httpPost.setEntity(new UrlEncodedFormEntity(basicNameValuePairLinkedList));
        HttpResponse response = getHttpClient().execute(getHttpHost(), httpPost);
        return parseResponse(response, responseClass);
    }

    private static <E> AppHttpResponse<E> parseResponse(HttpResponse response, Class<E> responseClass) throws IOException {
        AppHttpResponse<E> appHttpResponse = new AppHttpResponse<E>();
        if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
            String json = IOUtils.toString(response.getEntity().getContent());
            Log.d("HTTP response", json);
            Gson gson = new GsonBuilder().setDateFormat(IEatApplication.DATE_PATTERN).create();
            E responseData = gson.fromJson(json, responseClass);
            appHttpResponse.setData(responseData);
        } else {
            appHttpResponse.setErrorMessage(String.valueOf(response.getStatusLine().getStatusCode()));
        }
        return appHttpResponse;
    }

    private static <E> AppHttpResponse<E> parseResponse(HttpResponse response, Type type) throws IOException {
        AppHttpResponse<E> appHttpResponse = new AppHttpResponse<E>();
        if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
            String json = IOUtils.toString(response.getEntity().getContent());
            Log.d("HTTP response", json);
            Gson gson = new GsonBuilder().setDateFormat(IEatApplication.DATE_PATTERN).create();
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

    public static AppHttpResponse<Group> post(String url, String postJsonData, Class<Group> responseClass) throws IOException {
        HttpPost httpPost = new HttpPost(url + "?token=" + IEatApplication.getToken());
        StringEntity entity = new StringEntity(postJsonData);
        httpPost.setEntity(entity);
        httpPost.setHeader("Accept", "application/json");
        httpPost.setHeader("Content-type", "application/json");

        HttpResponse response = getHttpClient().execute(getHttpHost(), httpPost);
        AppHttpResponse<Group> appHttpResponse = parseResponse(response, responseClass);
        return appHttpResponse;
    }
}
