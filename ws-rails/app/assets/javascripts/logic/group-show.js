var iEatGroupShow = (function(){

    function pageInit(){
        $("#group-show .buy-foods").bind("click",function(){

            var groupId = $("#group-show").data("id");
            $(document).undelegate("#user-restaurant-edit", "pageinit").delegate("#user-restaurant-edit", "pageinit", function (e) {
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