package com.thoughtworks.ieat.domain;

import com.google.gson.annotations.SerializedName;

import java.io.Serializable;
import java.util.LinkedList;

public class MyBill implements Serializable{

    @SerializedName("unpaid_orders")
    private LinkedList<Order> unpaidOrders;

    @SerializedName("payback_orders")
    private LinkedList<Order> paybackOrders;


    public LinkedList<Order> getUnpaidOrders() {
        return unpaidOrders;
    }

    public void setUnpaidOrders(LinkedList<Order> unpaidOrders) {
        this.unpaidOrders = unpaidOrders;
    }

    public LinkedList<Order> getPaybackOrders() {
        return paybackOrders;
    }

    public void setPaybackOrders(LinkedList<Order> paybackOrders) {
        this.paybackOrders = paybackOrders;
    }
}
