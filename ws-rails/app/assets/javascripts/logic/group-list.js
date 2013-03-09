var token = $.cookie("token");
var iEatGroupList = (function () {
    function reFreshGroupList() {
        iEatUtility.getTodayGroupList(token,function (data) {
            var data = refactorActiveData(data);
            var str = '';
            var myCreatedGroups = data.myCreatedGroups;
            var myCreateGroupsLength = myCreatedGroups.length;

            if(myCreateGroupsLength == 0){
                str += '<li>你没有创建如何组</li>';
            }else{
                for (var i = 0; i < myCreateGroupsLength; i++) {
                    str += createGroupItem(myCreatedGroups[i]);
                }
            }
            $("#group-list .my-orders-ul").html(str).listview('refresh');

            var str = '';
            var availableGroups = data.availableGroups;
            var availableGroupsLength = availableGroups.length;

            if(availableGroupsLength == 0){
                str += '<li>现在暂时没有其他人创建的组</li>'
            }else{
                for (var i = 0; i < availableGroupsLength; i++) {
                    str += createGroupItem(availableGroups[i]);
                }
            }
            $("#group-list .group-list-ul").html(str).listview('refresh');

            bindEvent();

        });

        function createGroupItem(itemData){
            return  '<li><a class="group-item" href="javascript:void(0);" data-id="'+itemData.id+'" data-role-type=""><span class="group-name">' + itemData.name + '</span><span class="restaurant-name">' + itemData["restaurant"].name + '</span>Owner : ' + itemData.owner.name + '</a></li>';
        }

    }

    function refactorActiveData(data){
        var userName = $.cookie("userName");
        var myCreatedGroups = [];
        var availableGroups = [];
        $.each(data,function(index,item){
            if(item["owner"]["name"] == userName){
                myCreatedGroups.push(item);
            }else{
                availableGroups.push(item);
            }
        });

        return {
            "myCreatedGroups" : myCreatedGroups,
            "availableGroups" : availableGroups
        }
    }

    function bindEvent() {

        $("#group-list .create-group").bind("click", function () {
            window.location.href = "/groups/new";
        });

        $("#group-list .group-item").bind("click", function () {
            var currentGroupId = $(this).data("id");
            $.cookie("currentGroupId",currentGroupId,{ expires: 1, path: '/' });
            window.location.href = "/groups/"+currentGroupId;
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

$(document).bind("pageinit",function(){
    iEatGroupList.pageInit();
});

