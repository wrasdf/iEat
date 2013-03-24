package com.thoughtworks.ieat.service;

import com.google.gson.reflect.TypeToken;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.domain.AppHttpResponse;
import com.thoughtworks.ieat.domain.Group;
import com.thoughtworks.ieat.domain.Restaurant;
import com.thoughtworks.ieat.domain.UserToken;
import com.thoughtworks.ieat.utils.HttpUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Server {
    public static AppHttpResponse<UserToken> signIn(String username, String password) {
        AppHttpResponse<UserToken> appHttpResponse = new AppHttpResponse<UserToken>();
        try {
            String url = "/api/v1/users/sign_in";
            Map<String, String> postParams = new HashMap<String, String>();
            postParams.put("data", username);
            postParams.put("password", password);

            appHttpResponse = HttpUtils.post(url, postParams, UserToken.class);

            if (appHttpResponse.isSuccessful()) {
                IEatApplication.token = appHttpResponse.getData().getToken();
                IEatApplication.login(appHttpResponse.getData().getName());
            }
        } catch (Exception e) {
            appHttpResponse.setException(e);
        }
        return appHttpResponse;
    }

    public static AppHttpResponse<List<Group>> getActiveGroups() {
        AppHttpResponse<List<Group>> appHttpResponse;
        try {
            String url = "/api/v1/groups/active.json";
            appHttpResponse = HttpUtils.get(url, new TypeToken<List<Group>>() {}.getType());
        } catch (Exception e) {
            appHttpResponse = new AppHttpResponse<List<Group>>();
            appHttpResponse.setException(e);
        }
        return appHttpResponse;
    }

    public static AppHttpResponse<Group> getGroup(Integer groupId) {
        AppHttpResponse<Group> appHttpResponse;
        try {
            appHttpResponse = HttpUtils.get("/groups/" + groupId + ".json", Group.class);
        } catch (Exception e) {
            appHttpResponse = new AppHttpResponse<Group>();
            appHttpResponse.setException(e);
        }
        return appHttpResponse;
    }

    public static AppHttpResponse<Group> createGroup(String groupName, String restaurantId, String dueTimeStr) {
        AppHttpResponse<Group> appHttpResponse;
        HashMap<String, String> params = new HashMap<String, String>();
        params.put("restaurant_id", restaurantId);
        params.put("name", groupName);
        params.put("due_date", dueTimeStr);
        try {
            appHttpResponse = HttpUtils.post("/api/v1/groups/create", params, Group.class);
        } catch (Exception e) {
            appHttpResponse = new AppHttpResponse<Group>();
            appHttpResponse.setException(e);
        }
        return appHttpResponse;
    }

    public static AppHttpResponse<List<Restaurant>> getRestaurants() {
        AppHttpResponse<List<Restaurant>> appHttpResponse;
        try {
            appHttpResponse = HttpUtils.get("/api/v1/restaurants", new TypeToken<List<Restaurant>>() {}.getType());
        } catch (Exception e) {
            appHttpResponse = new AppHttpResponse<List<Restaurant>>();
            appHttpResponse.setException(e);
        }
        return appHttpResponse;
    }
}
