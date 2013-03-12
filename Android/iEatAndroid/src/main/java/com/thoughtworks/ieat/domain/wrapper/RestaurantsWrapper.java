package com.thoughtworks.ieat.domain.wrapper;

import com.google.gson.annotations.SerializedName;
import com.thoughtworks.ieat.domain.Restaurant;

import java.util.List;

public class RestaurantsWrapper {

    @SerializedName("restaurant_list")
    private List<Restaurant> allRestaurants;

    public List<Restaurant> getAllRestaurants() {
        return allRestaurants;
    }

    public void setAllRestaurants(List<Restaurant> allRestaurants) {
        this.allRestaurants = allRestaurants;
    }
}
