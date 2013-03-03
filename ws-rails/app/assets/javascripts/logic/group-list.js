var iEatGroupList = (function () {

    function reFreshGroupList() {
        iEatUtility.getTodayGroupList(function (data) {
            var str = '';
            var myGroupsData = data.myGroups;
            for (var i = 0, len = myGroupsData.length; i < len; i++) {
                str += '<li><a href="javascript:void(0);" data-id="'+myGroupsData[i].id+'" data-role-type="owner"><span class="group-name">' + myGroupsData[i].name + '</span><span class="restaurant-name">' + myGroupsData[i]["restaurant"].name + '</span>Owner : ' + myGroupsData[i].owner + '</a></li>';
            }
            $("#group-list .my-orders-ul").html(str).listview('refresh');

            var str = '';
            var groupListData = data.groupList;
            for (var i = 0, len = groupListData.length; i < len; i++) {
                str += '<li><a href="javascript:void(0);" data-id="'+groupListData[i].id+'" data-role-type="member"><span class="group-name">' + groupListData[i].name + '</span><span class="restaurant-name">' + groupListData[i]["restaurant"].name + '</span>Owner : ' + groupListData[i].owner + '</a></li>';
            }

            $("#group-list .group-list-ul").html(str).listview('refresh');
            groupListClick();
        })
    }

    function groupListClick() {

        $("#group-list .group-list-ul li a,#group-list .my-orders-ul li a").bind("click", function (e) {
            GROUPID = $(this).data('id');

            $(document).undelegate("#group-show", "pageshow").delegate("#group-show", "pageshow", function (e) {
                e.preventDefault();
                iEatGroupShow.pageInit();
            });

            $.mobile.changePage("/groups/"+GROUPID);
        });

        $(document).undelegate("#create-group", "pageinit").delegate("#create-group", "pageinit", function (e) {
            e.preventDefault();
            iEatCreate.pageInit();
        });

        $("#group-list .create-group").bind("click", function () {
            $.mobile.changePage("/groups/new");
        });

    }

    function pageInit(f) {
        if(f && typeof f == "function"){
            f();
        }
        reFreshGroupList()
    }

    return {
        pageInit: pageInit
    }

})();
