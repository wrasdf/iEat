package com.thoughtworks.ieat.domain;

import java.io.Serializable;

public class Group implements Serializable {

    public static final String DATE_PATTERN = "yyyy-MM-dd";
    private Integer id;

    private String name;

    private String owner;

    private Restaurant restaurant;

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

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public Restaurant getRestaurant() {
        return restaurant;
    }

    public void setRestaurant(Restaurant restaurant) {
        this.restaurant = restaurant;
    }
}
