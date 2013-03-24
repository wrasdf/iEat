package com.thoughtworks.ieat.domain;

import com.google.gson.annotations.SerializedName;

import java.io.Serializable;
import java.util.Date;

public class Group implements Serializable {

    private Integer id;

    private String name;

    private User owner;

    private Restaurant restaurant;

    @SerializedName("created_at")
    private Date created;

    @SerializedName("due_date")
    private Date dueDate;


    @SerializedName("restaurant_id")
    private Integer restaurantId;

    private String description;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public User getOwner() {
        return owner;
    }

    public void setOwner(User owner) {
        this.owner = owner;
    }

    public Restaurant getRestaurant() {
        return restaurant;
    }

    public void setRestaurant(Restaurant restaurant) {
        this.restaurant = restaurant;
    }

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(Integer restaurantId) {
        this.restaurantId = restaurantId;
        if (restaurant == null) {
            restaurant = new Restaurant();
        }
        restaurant.setId(restaurantId);

    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
