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

                if(!iEatUtility.isTokenValid(data)){
                    return false;
                }

                if(callback){
                    callback(data);
                }
            },
            error : function(){
                alert("API : /api/v1/restaurants is ERROR!");
            }
        });

    }

    function isTokenValid(response){
        if(response && response.error == "Token is invalid."){
            iEatUtility.msg({
                type: "error",
                msg: response.error,
                cb : function(){
                    window.location.href = "/users/sign_in";
                }
            });
            return false;
        }
        return true;
    }

    return {
        isTokenValid : isTokenValid,
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
        var config = $.extend({
            type: "success",
            msg: "",
            cb : function(){}
        },obj || {});

        $("<div class='ui-msg "+config.type+"'>"+config.msg+"</div>")
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
                config.cb();
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

    function escapeHtmlEntities(str){
        return $("<div />").text(str).html();
    }

    return {
        clearLoading : clearLoading,
        escapeHtmlEntities : escapeHtmlEntities
    }

})());


$.extend(iEatUtility,(function(){

    function devicesTrack(){

        var iOSDevice = /ipad|iphone|ipod/i.test(navigator.userAgent.toLowerCase());
        var isAndroid = /android/i.test(navigator.userAgent.toLowerCase());

        if (isAndroid){
            return "Android";
        }

        if (iOSDevice){
            return "iOS";
        }

        return "";
    }

    return {
        devicesTrack : devicesTrack
    }

})());
