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
                alert("API : /api/v1/groups/active is ERROR!");
            }
        });
    }

    function getAllRestaurants(token,callback){

        $.ajax({
            type : "get",
            url : "/api/v1/restaurants?token="+token,
            dataType:'json',
            success : function(data){
                if(callback){
                    callback(data);
                }
            },
            error : function(){
                alert("API : /api/v1/restaurants is ERROR!");
            }
        });

    }

    return {
        getTodayGroupList : getTodayGroupList,
        getAllRestaurants : getAllRestaurants
    }

})();

$.extend(iEatUtility,(function(){

    function clearCookie(){

        $.removeCookie('_ws-rails_session', { path: '/' });
        $.removeCookie('token', { path: '/' });
        $.removeCookie('selectedRestaurantId', { path: '/' });
        $.removeCookie('createGroupName', { path: '/' });
        $.removeCookie('currentGroupId', { path: '/' });
    }

    function securityCheck(){
        var token = $.cookie("token");
        if(token == "null" || !token){
            window.location.href = "/users/sign_in";
        }
    }

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
        clearCookie : clearCookie,
        securityCheck : securityCheck,
        msg : message
    }

})());


$.extend(iEatUtility,(function(){

    function clearLoading(dom){
        $(".loading").hide();
        dom.show();
    }

    return {
        clearLoading : clearLoading
    }

})());