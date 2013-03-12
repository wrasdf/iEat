package com.thoughtworks.ieat.domain.wrapper;

import com.google.gson.annotations.SerializedName;
import com.thoughtworks.ieat.domain.Group;

import java.util.List;

public class ActiveGroups {

    @SerializedName("active_groups")
    private List<Group> activeGroups;

    public List<Group> getActiveGroups() {
        return activeGroups;
    }

    public void setActiveGroups(List<Group> activeGroups) {
        this.activeGroups = activeGroups;
    }
}
