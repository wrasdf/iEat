
var iEatUtility = (function(){


    function getTodayGroupList(callback){
        $.get("/todayGroupList",function(o){
            if(!o){
                alert("todayGroupList API is ERROR!");
                return false;
            }
            TODAYGROUPLIST = $.parseJSON(o);
            if(callback){
                callback(TODAYGROUPLIST);
            }
            
        }); 
    }

    function getAllRestaurants(callback){
        $.get("/restaurants",function(o){
            if(!o){
                alert("restaurants API is ERROR!");
                return false;
            }
            RESTAURANTS = $.parseJSON(o);
            if(callback){
                callback(RESTAURANTS);
            }
        });
    }

    function getRestaurantDetailsByName(name){
        var  result = [];
        $.each(RESTAURANTS,function(index,value){
            if(name == value.name){
                result = RESTAURANTS[index];
                return false;
            }
        });
        return result;
    }

    return {
        getTodayGroupList : getTodayGroupList,
        getAllRestaurants : getAllRestaurants,
        getRestaurantDetailsByName : getRestaurantDetailsByName
    }

})();
