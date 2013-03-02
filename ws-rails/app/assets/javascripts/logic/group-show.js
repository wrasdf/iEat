var iEatGroupShow = (function(){

    function pageInit(){
        $("#group-show .buy-foods").bind("click",function(){

            var groupId = $("#group-show").data("id");
            $(document).undelegate("#user-order-dishes", "pageinit").delegate("#user-order-dishes", "pageinit", function (e) {
                e.preventDefault();
                iEatGroupDetails.pageInit();
            });

            $.mobile.changePage("/groups/"+groupId+"/orders/new");
        });

    }

    return {
        pageInit : pageInit
    }

})();