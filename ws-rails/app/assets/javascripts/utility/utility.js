
var iEatUtility = (function(){

    function getTodayGroupList(callback){
        $.get("/groups/today",function(o){
            if(!o){
                alert("todayGroupList API is ERROR!");
                return false;
            }
            TODAYGROUPLIST = o;

            if(callback){
                callback(TODAYGROUPLIST);
            }
            
        }, "json");
    }

    function getAllRestaurants(callback){
        $.get("/restaurants",function(o){
            if(!o){
                alert("restaurants API is ERROR!");
                return false;
            }
            RESTAURANTS = o;
            if(callback){
                callback(RESTAURANTS);
            }
        }, "json");
    }

    function getRestaurantDetailsById(id){
        var  result = [];
        $.each(RESTAURANTS,function(index,value){
            if(id == value["_id"]){
                result = RESTAURANTS[index];
                return false;
            }
        });
        return result;
    }

    return {
        getTodayGroupList : getTodayGroupList,
        getAllRestaurants : getAllRestaurants,
        getRestaurantDetailsById : getRestaurantDetailsById
    }

})();

$.extend(iEatUtility,(function(){

    function message(obj){

        $("<div class='ui-msg "+obj.type+"'>"+obj.msg+"</div>")
            .appendTo( $.mobile.pageContainer )
            .delay( 1500 )
            .fadeOut( 400, function(){
                $(this).remove();
            });
    }

    return {
        msg : message
    }

})());