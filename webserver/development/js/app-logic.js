$.mobile.defaultPageTransition = "slidefade";
var RESTAURANTS = null;
var TODAYGROUPLIST = null;
// get restaurants data

$( document ).bind( "pageinit", function( e, data ){

    e.preventDefault();
    iEatUtility.getAllRestaurants();
    iEatUI.reFreshGroupList();

});


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

    return {
        getTodayGroupList : getTodayGroupList,
        getAllRestaurants : getAllRestaurants
    }

})();

var iEatUI = (function(){

    function reFreshGroupList(){

        iEatUtility.getTodayGroupList(function(data){
            var str = '';

            for(var i =0,len = data.length ; i< len; i++){
                str += '<li><a href="#user-restaurant-edit" data-owner-name="'+data[i].name+'">'+data[i].name+data[i].date+'  Owner : '+data[i].owner+'</a></li>';
            }
            $("#user-restaurant-list .group-list-ul").html(str).listview('refresh');
            groupListClick();
            
        });
        
    }

    function groupListClick(){
        $("#user-restaurant-list .group-list-ul li a").bind("click",function(e){
            console.log($(e.target).data("owner-name"));
        })
    }


    return {
        reFreshGroupList : reFreshGroupList
        // groupListClick : groupListClick
    }

})();

// date picker
$(function(){
    
    $('#timePicker').mobiscroll().time({
        theme: 'iOS',
        display: 'inline',
        mode: 'scroller',
        onChange:function(text,b){
        	setValue(b.values);
        }
    });
    
    function setValue(array){
    	$("#show-Time").html(array[0] + " : " + (array[1] == 0 ? ("0"+"0") : array[1] < 9 ? "0"+ array[1] : array[1]) + (array[2] == 1 ? " PM" : " AM"));
    }

    setValue($('#timePicker').mobiscroll("getValue"));

});