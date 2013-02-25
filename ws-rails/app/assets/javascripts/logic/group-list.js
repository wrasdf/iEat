


var iEatGroupList = (function () {

    function reFreshGroupList() {
        iEatUtility.getTodayGroupList(function (data) {
            var str = '';
            var myGroupsData = data.myGroups;
            for (var i = 0, len = myGroupsData.length; i < len; i++) {
                str += '<li><a href="javascript:void(0);" data-id="'+myGroupsData[i]["_id"]+'" data-role-type="owner" data-restaurant-name="' + myGroupsData[i].name + '"><span class="restaurant-name">' + myGroupsData[i].name + '</span>Owner : ' + myGroupsData[i].owner + '</a></li>';
            }
            $("#group-list .my-orders-ul").html(str).listview('refresh');

            var str = '';
            var groupListData = data.groupList;
            for (var i = 0, len = groupListData.length; i < len; i++) {
                str += '<li><a href="javascript:void(0);" data-id="'+groupListData[i]["_id"]+'" data-role-type="member" data-restaurant-name="' + groupListData[i].name + '"><span class="restaurant-name">' + groupListData[i].name + '</span>Owner : ' + groupListData[i].owner + '</a></li>';
            }

            $("#group-list .group-list-ul").html(str).listview('refresh');
            groupListClick();
        })
    }

    function groupListClick() {

        $("#group-list .group-list-ul li a,#group-list .my-orders-ul li a").bind("click", function (e) {
            var name = $(e.target).data("restaurant-name");
            var _id = $(e.target).data("id");
            var data = {
                currentRestaurantData: iEatUtility.getRestaurantDetailsById(_id),
                type: $(e.target).data("role-type"),
                restaurantName: name
            };
            $(document).undelegate("#user-restaurant-edit", "pageinit").delegate("#user-restaurant-edit", "pageinit", function (e) {
                e.preventDefault();
                iEatGroupDetails.pageInitByData(data);
            })
            $.mobile.changePage("/groups/"+_id+"/edit");
        });

        $(document).undelegate("#my-bills", "pageinit").delegate("#my-bills", "pageinit", function (e) {
            e.preventDefault();
            iEatMyBills.pageInit();
        });

        $(document).undelegate("#create-content", "pageinit").delegate("#create-content", "pageinit", function (e) {
            e.preventDefault();
            iEatCreate.pageInit();
        });

        $("#group-list .my-bills-btn").bind("click", function () {
            $.mobile.changePage("/mybills");
        });

        $("#group-list .create-group").bind("click", function () {
            $.mobile.changePage("/create");
        });

    }

    function pageInit() {
        reFreshGroupList()
    }

    return {
        pageInit: pageInit
    }

})();
