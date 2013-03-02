package com.thoughtworks.ieat.utils;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.thoughtworks.ieat.domain.AppHttpResponse;
import com.thoughtworks.ieat.domain.Group;
import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;

import java.io.IOException;
import java.io.Serializable;
import java.util.LinkedList;

public class HttpUtils {

    private static HttpClient httpClient;
    private static HttpHost httpHost;

    public static HttpResponse login(String username, String password) {
        httpHost = getHttpHost();
        AppHttpResponse appHttpResponse = new AppHttpResponse();
        try {
            HttpPost httpPost = new HttpPost("/api/v1/users/sign_in");
            LinkedList<BasicNameValuePair> basicNameValuePairLinkedList = new LinkedList<BasicNameValuePair>();
            basicNameValuePairLinkedList.add(new BasicNameValuePair("email", username));
            basicNameValuePairLinkedList.add(new BasicNameValuePair("password", password));
            httpPost.setEntity(new UrlEncodedFormEntity(basicNameValuePairLinkedList));
            HttpResponse response = getHttpClient().execute(getHttpHost(), httpPost);
            return response;
        } catch (IOException e) {
            appHttpResponse.setException(e);
        }
        return null;
    }

    public static AppHttpResponse signIn(String username, String password) {
        httpHost = getHttpHost();
        AppHttpResponse appHttpResponse = new AppHttpResponse();
        try {
            HttpPost httpPost = new HttpPost("/api/v1/users/sign_in");
            LinkedList<BasicNameValuePair> basicNameValuePairLinkedList = new LinkedList<BasicNameValuePair>();
            basicNameValuePairLinkedList.add(new BasicNameValuePair("email", username));
            basicNameValuePairLinkedList.add(new BasicNameValuePair("password", password));
            httpPost.setEntity(new UrlEncodedFormEntity(basicNameValuePairLinkedList));
            HttpResponse response = getHttpClient().execute(getHttpHost(), httpPost);
            appHttpResponse = parseResponse(response, UserToken.class);
        } catch (IOException e) {
            appHttpResponse.setException(e);
        }
        return appHttpResponse;
    }

    public static HttpResponse getTodayGroup() {
        HttpGet httpGet = new HttpGet("/groups/today");
        try {
            return getHttpClient().execute(getHttpHost(), httpGet);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
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

    private static AppHttpResponse parseResponse(HttpResponse response, Class<UserToken> responseClass) {
        AppHttpResponse<UserToken> appHttpResponse = new AppHttpResponse<UserToken>();
        if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
            try {
                String json = IOUtils.toString(response.getEntity().getContent());
                Gson gson = new GsonBuilder().setDateFormat(Group.DATE_PATTERN).create();
                UserToken responseData = gson.fromJson(json, responseClass);
                appHttpResponse.setData(responseData);
            } catch (IOException e) {
                appHttpResponse.setException(e);
            }
        } else {
        }
        return appHttpResponse;
    }

    private static class UserToken implements Serializable {
        private String email;
        private String token;
        private boolean success;

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getToken() {
            return token;
        }

        public void setToken(String token) {
            this.token = token;
        }

        public boolean isSuccess() {
            return success;
        }

        public void setSuccess(boolean success) {
            this.success = success;
        }
    }
}
