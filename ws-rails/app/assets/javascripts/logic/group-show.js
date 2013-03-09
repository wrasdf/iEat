
var iEatGroupShow = (function(){

    var currentGroupId = $.cookie("currentGroupId");
    var token = $.cookie("token");

    function pageInit(f){

        if(f && typeof f == "function"){
            f();
        }

        getGroupDetails(function(group){
            updateGroupName(group.name);
            updateRestaurantDetails(group.restaurant);
        });

        $("#group-show .restaurant-info-btn").bind("click",function(){
            $("#group-show .details-content").hide();
            $("#group-show .group-details").show();
        });

        $("#group-show .all-info-btn").bind("click",function(){
            $("#group-show .details-content").hide();
            $("#group-show .all-status").show();
        });

        $("#group-show .my-orders-btn").bind("click",function(){
            $("#group-show .details-content").hide();
            $("#group-show .my-orders-details").show();
        });

        $("#group-show .members-orders-btn").bind("click",function(){
            $("#group-show .details-content").hide();
            $("#group-show .members-details").show();
        });

        $("#group-show .buy-foods").bind("click",function(){
            var currentGroupId = $.cookie("currentGroupId");
            window.location.href = "/groups/"+currentGroupId+"/orders/new";
        });

        $("#group-show .ui-btn-left").bind("click",function(){
            window.location.href = "/groups";
        });

    }

    function updateRestaurantDetails(restaurantData){
        var str = '<li><span class="subject">饭店名称</span><span>'+restaurantData.name+'</span></li>';
        str += '<li><span class="subject">订餐电话</span><span>'+restaurantData.telephone+'</span></li>';
        str += '<li><span class="subject">餐馆地址</span><span>'+restaurantData.address+'</span></li>';
        $("#group-show .restaurant-details").html(str).listview('refresh').show();
    }

    function updateGroupName(groupName){
        $(".group-name").html(groupName);
    }

    function updateGroupStatus(groupOrders){

    }

    function activeFooterItemByIndex(n){
        window.setTimeout(function(){
            if(n==0){
                $("#group-show .restaurant-info-btn").trigger("click");
            }

            if(n==1){
                $("#group-show .all-info-btn").trigger("click");
            }

            if(n==2){
                $("#group-show .my-orders-btn").trigger("click");
            }

            if(n==3){
                $("#group-show .members-orders-btn").trigger("click");
            }
        },10);
    }

    function getGroupDetails(callback){

        $.ajax({
            type : "get",
            url : "/api/v1/groups/"+currentGroupId+"?token="+token,
            dataType : "json",
            success : function(data){
                if(data){
                    if(callback){
                        callback(data);
                    }
                }
            },
            error : function(){
                alert("API : /api/v1/groups/:id is ERROR!");
            }
        });
    }

    return {
        pageInit : pageInit,
        activeFooterItemByIndex : activeFooterItemByIndex
    }

})();

$("#group-show").bind("pageinit",function(){
//    if(currentGroupId){
//        iEatUtility.msg({
//            type : "success",
//            msg : "Your Group is success created."
//        });
//    }
    iEatGroupShow.pageInit();

});

$(window).bind("load",function(){
    iEatGroupShow.activeFooterItemByIndex(0);
});