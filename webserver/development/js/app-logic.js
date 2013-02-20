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

            var myGroupsData = data.myGroups;
            for(var i =0,len = myGroupsData.length ; i< len; i++){
                str += '<li><a href="javascript:void(0);" data-role-type="member" data-restaurant-name="'+myGroupsData[i].name+'"><span class="restaurant-name">'+myGroupsData[i].name+'</span>Owner : '+myGroupsData[i].owner+'</a></li>';
            }
            $("#user-restaurant-list .my-orders-ul").html(str).listview('refresh');

            var str = '';
            var groupListData = data.groupList;
            for(var i =0,len = groupListData.length ; i< len; i++){
                str += '<li><a href="javascript:void(0);" data-role-type="order-food" data-restaurant-name="'+groupListData[i].name+'"><span class="restaurant-name">'+groupListData[i].name+'</span>Owner : '+groupListData[i].owner+'</a></li>';
            }
            $("#user-restaurant-list .group-list-ul").html(str).listview('refresh');

            groupListClick();
        });
        
    }

    function groupListClick(){
        $("#user-restaurant-list .group-list-ul li a,#user-restaurant-list .my-orders-ul li a").bind("click",function(e){
            var data = {};
            data.currentRestaurantData = iEatUtility.getRestaurantDetailsByName($(e.target).data("restaurant-name"));
            data.type = $(e.target).data("role-type")
            $.mobile.changePage("#user-restaurant-edit");
            iEatGroupDetails.pageInitByData(data);
            // iEatGroupDetails.reFreshGroupDetailsByData(currentRestaurantData);
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
            str += '<a href="" class="reduce" data-mini="true" data-role="button" data-icon="arrow-d">&nbsp;</a>';
            str += '<a href="" class="add" data-mini="true" data-role="button" data-icon="arrow-u">&nbsp;</a>';
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
        $("#user-restaurant-edit .edit-restaurant-details .add").bind("click",function(){
            var currentInput = $(this).parent().parent().parent().find("input.number-input");
            var v = currentInput.val();
            v++;
            currentInput.val(v);
            refreshMyOrderUI();
        });
        $("#user-restaurant-edit .edit-restaurant-details .reduce").bind("click",function(){
            var currentInput = $(this).parent().parent().parent().find("input.number-input");
            var v = currentInput.val();
            v--;
            if(v<=0){
                v = 0;
            }
            currentInput.val(v);
            refreshMyOrderUI();
        });
    }

    function showContentByName(name){
        function clearClass(){
            $("#user-restaurant-edit .footer-navbar a").removeClass("ui-btn-active").removeClass("ui-state-persist");
        }
        clearClass();
        if(name == "member"){

            $("#user-restaurant-edit .footer-navbar a.my-orders").addClass("ui-btn-active").addClass("ui-state-persist")
        }else if(name =="owner"){
            $("#user-restaurant-edit .footer-navbar a.group-orders").addClass("ui-btn-active").addClass("ui-state-persist")
        }else if(name =="order-food"){
            $("#user-restaurant-edit .footer-navbar a.my-orders").parent().remove();
            $("#user-restaurant-edit .footer-navbar a.edit-my-orders").addClass("ui-btn-active").addClass("ui-state-persist")
        }    
    }

    function getMyOrderGroups(){
        var result = [];
        $("#user-restaurant-edit .edit-restaurant-details li").each(function(index,value){
            if($(value).find(".number-input").val() == 0){
                return true;
            }
            result.push({
                "name" : $(value).find(".dish-name").text(),
                "price" : $(value).find(".dish-price").text(),
                "count" : $(value).find(".number-input").val()
            });
        });
        return result;
    }

    function refreshMyOrderUI(){
        var data = getMyOrderGroups();
        var str = "";
        var totalPrice = 0;
        $.each(data,function(index,value){
            str += '<li><span class="dish-name">'+value.name+'</span><span class="dish=price">'+value.price+'</span>￥<span class="ui-li-count">'+value.count+'</span></li>';    
            totalPrice += value.price * value.count;
        });

        str += '<li><span class="dishes-total">Total:</span><span>'+totalPrice+'</span>￥</li>';
        $("#user-restaurant-edit .my-order-list").html(str).listview("refresh");
    }

    function pageInitByData(data){
        console.log(data);
        showContentByName(data.type);
        $('#user-restaurant-edit').trigger('create');        
    }

    return {
        reFreshGroupDetailsByData : reFreshGroupDetailsByData,
        pageInitByData : pageInitByData
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