var iEatRestaurant = (function(){

    function pageInit(){

        $(".ui-btn-left").bind("click",function(){
            window.location.href = "/groups/new";
        });

        $(".restaurant-list-content li a").unbind("click").bind("click",function(e){
//            $.mobile.changePage("/groups/new");
        });

    }

    return {
        pageInit : pageInit
    }

})();

iEatRestaurant.pageInit();