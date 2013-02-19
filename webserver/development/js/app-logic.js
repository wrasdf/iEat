$.mobile.defaultPageTransition = "slidefade";
var RESTAURANTS = null;
var TODAYGROUPLIST = null;
// get restaurants data

$( "#user-restaurant-list" ).bind( "pageinit", function( e, data ){

    e.preventDefault();
    iEatUtility.getAllRestaurants();
    iEatGroupList.reFreshGroupList();

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


var iEatGroupList = (function(){

    function reFreshGroupList(){

        iEatUtility.getTodayGroupList(function(data){
            var str = '';
            var data = data.groupList;
            for(var i =0,len = data.length ; i< len; i++){
                str += '<li><a href="javascript:void(0);" data-owner-name="'+data[i].name+'">'+data[i].name+data[i].date+'  Owner : '+data[i].owner+'</a></li>';
            }
            $("#user-restaurant-list .group-list-ul").html(str).listview('refresh');
            groupListClick();
        });
        
    }

    function groupListClick(){
        $("#user-restaurant-list .group-list-ul li a").bind("click",function(e){
            var currentRestaurantData = iEatUtility.getRestaurantDetailsByName($(e.target).data("owner-name"));
            $.mobile.changePage("#user-restaurant-edit");
            iEatGroupDetails.reFreshGroupDetailsByData(currentRestaurantData);
        })
    }


    return {
        reFreshGroupList : reFreshGroupList
    }

})();

var iEatGroupDetails = (function(){

    function reFreshGroupDetailsByData(o){
        var str = "";
        $.each(o.menu,function(index,value){
            str += '<li class="cf">';
            str += '<span class="restaurant-content"><span class="dish-name">'+value.dish+'</span><span class="dish-price">'+value.price+'</span>￥</span>';
            str += '<span class="ui-li-count">3</span>';
            str += '<div class="group-button-content" data-role="controlgroup" data-type="horizontal">';
            str += '<a href="" class="add" data-mini="true" data-role="button" data-icon="arrow-u">&nbsp;</a>';
            str += '<a href="" class="reduce" data-mini="true" data-role="button" data-icon="arrow-d">&nbsp;</a>';
            str += '</div>';
            str += '<input type="number" data-mini="true" class="number-input" value="0"  />';
            str += '</li>';
        });
        $("#user-restaurant-edit h1").html(o.name);    
        $("#user-restaurant-edit .edit-restaurant-details").html(str).listview("refresh");
        $('#user-restaurant-edit').trigger('create');
        bindFunction();
    }

    function bindFunction(){
        $("#user-restaurant-edit .restaurant-details .add").bind("click",function(){
            var currentInput = $(this).parent().parent().parent().find("input.number-input");
            var v = currentInput.val();
            v++;
            currentInput.val(v);
        });
        $("#user-restaurant-edit .restaurant-details .reduce").bind("click",function(){
            var currentInput = $(this).parent().parent().parent().find("input.number-input");
            var v = currentInput.val();
            v--;
            if(v<=0){
                v = 0;
            }
            currentInput.val(v);
        })
    }

    return {
        reFreshGroupDetailsByData : reFreshGroupDetailsByData 
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