package com.thoughtworks.ieat.service;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.thoughtworks.ieat.IEatApplication;
import com.thoughtworks.ieat.domain.*;
import com.thoughtworks.ieat.utils.HttpUtils;

import java.io.IOException;
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
                IEatApplication.login(appHttpResponse.getData().getName(), appHttpResponse.getData().getToken());
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
            appHttpResponse = HttpUtils.get("/api/v1/groups/" + groupId + ".json", Group.class);
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

    public static AppHttpResponse<List<Dishes>> listDishes(Integer groupId) {
        AppHttpResponse<List<Dishes>> appHttpResponse;
        try {
            appHttpResponse = HttpUtils.get("/api/v1/groups/" + groupId + "/dishes", new TypeToken<List<Dishes>>() {}.getType());
        } catch (Exception e) {
            appHttpResponse = new AppHttpResponse<List<Dishes>>();
            appHttpResponse.setException(e);
        }
        return appHttpResponse;
    }

    public static AppHttpResponse<Group> createOrder(Integer groupId, List<Map<String, String>> selectedDishList) {
        AppHttpResponse<Group> appHttpResponse;
        Gson gson = new GsonBuilder().create();
        String orderDishListJson = gson.toJson(selectedDishList);
        HashMap<String, String> postContent = new HashMap<String, String>();
        postContent.put("dishes", orderDishListJson);
        String postJsonData = gson.toJson(postContent);
        try {
            appHttpResponse = HttpUtils.post("/api/v1/groups/" + groupId + "/orders/create", postJsonData, Group.class);
        } catch (Exception e) {
            appHttpResponse = new AppHttpResponse<Group>();
            appHttpResponse.setException(e);
        }
        return appHttpResponse;
    }

    public static AppHttpResponse<MyBill> getMyBill() {
        AppHttpResponse<MyBill> appHttpResponse;
        try {
            appHttpResponse = HttpUtils.get("/api/v1/mybills", MyBill.class);
        } catch (IOException e) {
            appHttpResponse = new AppHttpResponse<MyBill>();
            appHttpResponse.setException(e);
        }
        return appHttpResponse;
    }

    public static AppHttpResponse<User> signUp(Map<String, String> userInfo) {
        AppHttpResponse<User> appHttpResponse;
        try {
            appHttpResponse = HttpUtils.post("/api/v1/users", userInfo, User.class);
        } catch (Exception e) {
            appHttpResponse = new AppHttpResponse<User>();
            appHttpResponse.setException(e);
        }
        return appHttpResponse;
    }
}
