package com.thoughtworks.ieat.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class Restaurant implements Serializable {

    private Integer id;

    private String name;

    private Date date;

    private String telephone;

    private String address;

    private List<Dish> dishes;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
