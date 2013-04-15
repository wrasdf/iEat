
var iEatGroupList = (function () {
    var token = $.cookie("token");
    function reFreshGroupList() {
        iEatUtility.getTodayGroupList(token,function (data) {

            if(!iEatUtility.isTokenValid(data)){
                return false;
            }

            var data = refactorActiveData(data);
            var str = '';
            var myRelatedGroups = data.myRelatedGroups;
            var myCreateGroupsLength = myRelatedGroups.length;

            if(myCreateGroupsLength == 0){
                str += '<li>没有与您相关的团</li>';
            }else{
                for (var i = 0; i < myCreateGroupsLength; i++) {
                    str += createGroupItem(myRelatedGroups[i]);
                }
            }
            $("#group-list .my-orders-ul").html(str).listview('refresh');

            var str = '';
            var availableGroups = data.availableGroups;
            var availableGroupsLength = availableGroups.length;

            if(availableGroupsLength == 0){
                str += '<li>现在暂时没有其他可加入的团</li>'
            }else{
                for (var i = 0; i < availableGroupsLength; i++) {
                    str += createGroupItem(availableGroups[i]);
                }
            }
            $("#group-list .group-list-ul").html(str).listview('refresh');
            bindEvent();

        });

        function createGroupItem(itemData){
            var customizeIconClass = "";

            var userName = $.cookie("userName");
            if(itemData["owner"]["name"] == userName){
                customizeIconClass = "created"
            }else if(itemData["joined"]){
                customizeIconClass = "joined"
            }

            return  '<li><a class="group-item '+customizeIconClass+'" href="javascript:void(0);" data-id="'+itemData.id+'" data-role-type=""><span class="group-name">' + iEatUtility.escapeHtmlEntities(itemData.name) + '</span><span class="restaurant-name">' + itemData["restaurant"].name + '</span></a></li>';
        }

    }

    function refactorActiveData(data){
        var userName = $.cookie("userName");
        var myRelatedGroups = [];
        var availableGroups = [];
        $.each(data,function(index,item){
            if(item["owner"]["name"] == userName || item["joined"]){
                myRelatedGroups.push(item);
            }else{
                availableGroups.push(item);
            }
        });

        return {
            "myRelatedGroups" : myRelatedGroups,
            "availableGroups" : availableGroups
        }
    }

    function bindEvent() {

        $("#group-list .log-out").bind("click",function(){
            $.ajax({
                type : 'GET',
                url : "/users/sign_out",
                success : function(){
                    iEatUtility.clearCookie();
                    window.location.href = "/users/sign_in";
                },
                error : function (xhr) {
                    iEatUtility.msg({
                        type:"error",
                        msg : $.parseJSON(xhr.responseText).message
                    });
                }
            });
        });

        $("#group-list .create-group").bind("click", function () {
            window.location.href = "/groups/new";
        });

        $("#group-list .ui-btn-right.my-bills").bind("click", function () {
            window.location.href = "/mybills#0";
        });

        $("#group-list .group-item").bind("click", function () {
            var currentGroupId = $(this).data("id");
            $.cookie("currentGroupId",currentGroupId,{ expires: 14, path: '/' });
            window.location.href = "/groups/"+currentGroupId;
        });


    }

    function pageInit() {
        iEatUtility.clearLoading($("#group-list"));
        reFreshGroupList()
    }

    return {
        pageInit: pageInit
    }

})();

$(document).bind("pageshow",function(){
    iEatUtility.securityCheck();
    iEatGroupList.pageInit();
});


