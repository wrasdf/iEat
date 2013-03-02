package com.thoughtworks.ieat.domain;

import java.io.Serializable;
import java.util.List;

public class GroupList implements Serializable {

    private List<Group> myGroups;

    private List<Group> groupList;

    public List<Group> getGroupList() {
        return groupList;
    }

    public void setGroupList(List<Group> groupList) {
        this.groupList = groupList;
    }

    public List<Group> getMyGroups() {
        return myGroups;
    }

    public void setMyGroups(List<Group> myGroups) {
        this.myGroups = myGroups;
    }
}
