package com.thoughtworks.ieat.utils;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.domain.AppHttpResponse;
import com.thoughtworks.ieat.domain.Group;
import com.thoughtworks.ieat.domain.Restaurant;
import com.thoughtworks.ieat.domain.UserToken;
import com.thoughtworks.ieat.domain.wrapper.RestaurantsWrapper;
import de.akquinet.android.androlog.Log;
import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.BasicHttpParams;

import java.io.IOException;
import java.lang.reflect.Type;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class HttpUtils {

    private static HttpClient httpClient;
    private static HttpHost httpHost;

    private static String token;


    public static AppHttpResponse<UserToken> signIn(String username, String password) {
        AppHttpResponse<UserToken> appHttpResponse = new AppHttpResponse<UserToken>();
        try {
            String url = "/api/v1/users/sign_in";
            Map<String, String> postParams = new HashMap<String, String>();
            postParams.put("email", username);
            postParams.put("password", password);

            HttpResponse response = post(url, postParams);
            appHttpResponse = parseResponse(response, UserToken.class);

            if (appHttpResponse.isSuccessful()) {
                token = appHttpResponse.getData().getToken();
            }
        } catch (Exception e) {
            appHttpResponse.setException(e);
        }
        return appHttpResponse;
    }

    public static AppHttpResponse<List<Group>> getActiveGroups() {
        AppHttpResponse<List<Group>> appHttpResponse = new AppHttpResponse<List<Group>>();
        try {
            String url = "/api/v1/groups/active.json";
            HttpResponse response= get(url);
            appHttpResponse = parseResponse(response, new TypeToken<List<Group>>(){}.getType());
        } catch (Exception e) {
            appHttpResponse.setException(e);
        }
        return appHttpResponse;
    }

    public static AppHttpResponse<Group> getGroup(Integer groupId) {
        AppHttpResponse<Group> appHttpResponse = new AppHttpResponse<Group>();
        try {
            HttpResponse response = get("/groups/" + groupId + ".json");
            appHttpResponse = parseResponse(response, Group.class);
        } catch (Exception e) {
            appHttpResponse.setException(e);
        }
        return appHttpResponse;
    }

    public static AppHttpResponse<Group> createGroup(String groupName, String restaurantId, String dueTimeStr) {
        AppHttpResponse<Group> appHttpResponse = new AppHttpResponse<Group>();
        HashMap<String, String> params = new HashMap<String, String>();
        params.put("restaurant_id", restaurantId);
        params.put("name", groupName);
        params.put("due_date", dueTimeStr);
        try {
            HttpResponse httpResponse = post("/api/v1/groups/create", params);
            parseResponse(httpResponse, Group.class);
        } catch (Exception e) {
            appHttpResponse.setException(e);
        }
        return appHttpResponse;
    }

    public static AppHttpResponse<RestaurantsWrapper> getRestaurants() {
        AppHttpResponse<RestaurantsWrapper> appHttpResponse = new AppHttpResponse<RestaurantsWrapper>();
        try {
            HttpResponse response = get("/api/v1/restaurants");
            appHttpResponse = parseResponse(response, RestaurantsWrapper.class);
        } catch (Exception e) {
            appHttpResponse.setException(e);
        }
        return appHttpResponse;
    }

    private static HttpResponse post(String url, Map<String, String> postParams) throws IOException {
        HttpPost httpPost = new HttpPost(url + "?token=" + token);
        LinkedList<BasicNameValuePair> basicNameValuePairLinkedList = new LinkedList<BasicNameValuePair>();
        for (Map.Entry<String, String> param : postParams.entrySet()) {
            basicNameValuePairLinkedList.add(new BasicNameValuePair(param.getKey(), param.getValue()));
        }
        httpPost.setEntity(new UrlEncodedFormEntity(basicNameValuePairLinkedList));
        return getHttpClient().execute(getHttpHost(), httpPost);
    }

    private static HttpResponse get(String url) throws IOException {
        HttpGet httpGet = new HttpGet(url + "?token=" + token);
        httpGet.setHeader("Accept", "application/json");
        return getHttpClient().execute(getHttpHost(), httpGet);
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
}
