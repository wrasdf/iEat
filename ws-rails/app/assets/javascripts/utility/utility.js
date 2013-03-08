// global mobile setting
$.mobile.defaultPageTransition = "slidefade";

var iEatUtility = (function(){

    function getTodayGroupList(token,callback){
        $.ajax({
            type : "get",
            url : "/api/v1/groups/active?token="+token,
            dataType:'json',
            success : function(data){
                if(callback){
                    callback(data);
                }
            },
            error : function(){
                alert("API : groups#active is ERROR!");
            }
        });
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
            .appendTo($.mobile.pageContainer)
            .css({
                "top":"-"+(parseInt($('.ui-msg').innerHeight()+1))
            })
            .animate({
                "top" : "0"
            },500)
            .delay( 1500 )
            .fadeOut( 400, function(){
                $(this).remove();
            });
    }

    return {
        msg : message
    }

})());