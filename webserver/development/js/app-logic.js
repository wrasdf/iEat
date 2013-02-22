$.mobile.defaultPageTransition = "slidefade";
$.mobile.page.prototype.options.domCache = false;



var RESTAURANTS = null;
var TODAYGROUPLIST = null;

$( "#user-restaurant-list").bind( "pageinit", function( e, data ){
    e.preventDefault();
    iEatUtility.getAllRestaurants();
    iEatGroupList.reFreshGroupList();
});

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
            var name = $(e.target).data("restaurant-name");
            var data = {
                currentRestaurantData : iEatUtility.getRestaurantDetailsByName(name),
                type : $(e.target).data("role-type"),
                restaurantName : name
            };
            $(document).undelegate("#user-restaurant-edit","pageinit").delegate("#user-restaurant-edit","pageinit",function(e){
                e.preventDefault();
                iEatGroupDetails.pageInitByData(data);
            })
            $.mobile.changePage("/editGroup");
        })
    }


    return {
        reFreshGroupList : reFreshGroupList
    }

})();

var iEatGroupDetails = (function(){

    function reFreshMenuDetailsByData(o){
        var str = "";
        $.each(o.menu,function(index,value){
            str += '<li class="cf">';
            str += '<span class="restaurant-content"><span class="dish-name">'+value.dish+'</span><span class="dish-price">'+value.price+'</span>￥</span>';
            str += '<span class="ui-li-count">3</span>';
            str += '<div class="group-button-content" data-role="controlgroup" data-type="horizontal">';
            str += '<a href="" class="reduce" data-role="button" data-icon="minus">&nbsp;</a>';
            str += '<a href="" class="add" data-role="button" data-icon="plus">&nbsp;</a>';
            str += '</div>';
            str += '<input type="number" data-mini="true" class="number-input" value="0"  />';
            str += '</li>';
        });    
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

    function showContentByData(data){

        var name = data.type;

        function clearClass(){
            $("#user-restaurant-edit .footer-navbar a").removeClass("ui-btn-active").removeClass("ui-state-persist");
        }

        function resetFooterNavBarByName(name){
            
            var withMyOrderStr = '<div data-mini="true" data-role="navbar" class="footer-navbar"><ul><li><a href="javascript:void(0);" class="my-orders" data-role="tab" data-icon="star" data-transition="slideup">My Orders</a></li><li><a href="javascript:void(0);" class="group-orders" data-icon="grid" data-transition="slideup">Group Orders</a></li><li><a href="javascript:void(0);" class="edit-my-orders" data-icon="edit" data-transition="slideup">Edit</a></li></ul></div>'
            var withOutMyOrderStr = '<div data-mini="true" data-role="navbar" class="footer-navbar"><ul><li><a href="javascript:void(0);" class="group-orders" data-role="tab" data-icon="grid" data-transition="slideup">Group Orders</a></li><li><a href="javascript:void(0);" class="edit-my-orders" data-icon="edit" data-transition="slideup">Edit</a></li></ul></div>'

            if(name == "order-food"){
                $("#user-restaurant-edit .footer-navbar").html(withOutMyOrderStr);
            }else{
                $("#user-restaurant-edit .footer-navbar").html(withMyOrderStr);
            }
            clearClass();
        }

        function hideAll(){
            $("#user-restaurant-edit .my-orders-content").hide();
            $("#user-restaurant-edit .edit-my-orders-content").hide();
            $("#user-restaurant-edit .my-Group-content").hide();
        }

        function bindFooterNavBarClick(){

            $("#user-restaurant-edit .footer-navbar a.my-orders").unbind("click").bind("click",function(){
                 hideAll();
                 $("#user-restaurant-edit .my-orders-content").show(); 
                 console.log(data.currentRestaurantData); 
                 // refreshMyOrderUI(data.currentRestaurantData); 
            });
            $("#user-restaurant-edit .footer-navbar a.group-orders").unbind("click").bind("click",function(){
                hideAll();
                $("#user-restaurant-edit .my-Group-content").show();   



            });
            $("#user-restaurant-edit .footer-navbar a.edit-my-orders").unbind("click").bind("click",function(){
                hideAll();
                $("#user-restaurant-edit .edit-my-orders-content").show();
                // $("#user-restaurant-edit .footer-navbar a.edit-my-orders").trigger ("vclick");
                reFreshMenuDetailsByData(data.currentRestaurantData);
            });

        }

        resetFooterNavBarByName(name);
        bindFooterNavBarClick();

        if(name == "member"){
            $("#user-restaurant-edit .footer-navbar a.my-orders").trigger ("click");
        }else if(name =="owner"){
            $("#user-restaurant-edit .footer-navbar a.group-orders").trigger ("click");
        }else if(name =="order-food"){
            $("#user-restaurant-edit .footer-navbar a.edit-my-orders").trigger ("click");
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
        showContentByData(data);
        $('#user-restaurant-edit').bind('pagehide', function(){
            $(this).remove();
        });
        $("#user-restaurant-edit h1").html(data.restaurantName);
        $('#user-restaurant-edit').trigger('create');
        $('#user-restaurant-edit .confirm-foods').bind("click",function(){
            $.mobile.changePage("/success");
        })
    }

    return {
        reFreshMenuDetailsByData : reFreshMenuDetailsByData,
        pageInitByData : pageInitByData
    }

})();


var iEatSuccess = (function(){

    function pageInit(){

    }

    return {
        pageInit : pageInit
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