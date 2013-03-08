var currentGroupId = $.cookie("currentGroupId");
var iEatGroupShow = (function(){
    function pageInit(f){

        if(f && typeof f == "function"){
            f();
        }

        $("#group-show .restaurant-info-btn").bind("click",function(){
            $("#group-show .details-content").hide();
            $("#group-show .restaurant-details").show();
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
            window.location.href = "/groups/"+currentGroupId+"/orders/new";
        });

        $("#group-show .ui-btn-left").bind("click",function(){
            window.location.href = "/groups";
        });



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

    return {
        pageInit : pageInit,
        activeFooterItemByIndex : activeFooterItemByIndex
    }

})();

$("#group-show").bind("pageshow",function(){
    if(currentGroupId){
//        iEatUtility.msg({
//            type : "success",
//            msg : "Your Group is success created."
//        });
    }
    iEatGroupShow.pageInit();

});

$(window).bind("load",function(){
    iEatGroupShow.activeFooterItemByIndex(0);
});