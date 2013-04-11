package com.thoughtworks.ieat.domain;

import com.google.gson.annotations.SerializedName;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class Order implements Serializable {

    private Integer id;
    @SerializedName("created_at")
    private Date created;

    private Group group;

    private User user;

    @SerializedName("order_dishes")
    private List<OrderDish> orderDishs;

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Group getGroup() {
        return group;
    }

    public void setGroup(Group group) {
        this.group = group;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<OrderDish> getOrderDishs() {
        return orderDishs;
    }

    public void setOrderDishs(List<OrderDish> orderDishs) {
        this.orderDishs = orderDishs;
    }
}
