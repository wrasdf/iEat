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

            var groupId = $("#group-show").data("id");
            $(document).undelegate("#user-order-dishes", "pageinit").delegate("#user-order-dishes", "pageinit", function (e) {
                e.preventDefault();
                iEatGroupDetails.pageInit();
            });

            $.mobile.changePage("/groups/"+groupId+"/orders/new");
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
        },0);

    }

    return {
        pageInit : pageInit,
        activeFooterItemByIndex : activeFooterItemByIndex
    }

})();