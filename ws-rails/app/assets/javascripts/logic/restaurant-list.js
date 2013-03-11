var iEatRestaurant = (function(){

    function pageInit(){

        $(".ui-btn-left").bind("click",function(){
            window.location.href = "/groups/new";
        });

        $(".restaurant-list-content li a").unbind("click").bind("click",function(){
            $.cookie("selectedRestaurantId",$(this).data("id"),{ expires: 1, path: '/' });
            window.location.href = "/groups/new";
        });

    }

    return {
        pageInit : pageInit
    }

})();

iEatRestaurant.pageInit();