var iEatRestaurant = (function(){

    function pageInit(){

        $(document).undelegate("#create-group", "pageshow").delegate("#create-group", "pageshow", function (e) {
            e.preventDefault();
            iEatCreate.pageInit();
            console.log(SELECTGROUPID)
            iEatCreate.selectRadioByRestaurantId(SELECTGROUPID);
        });

        $(".restaurant-list-content li a").unbind("click").bind("click",function(e){
            SELECTGROUPID = $(this).data("id");
            $.mobile.changePage("/groups/new");
        });

    }

    return {
        pageInit : pageInit
    }

})();