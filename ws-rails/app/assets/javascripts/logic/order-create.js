
var iEatGroupDetails = (function () {

    var urlRegexp = /^.+\/(\d+)\/.+$/g;
    var currentGroupId = urlRegexp.exec(window.location.href)[1];
    var token = $.cookie("token");

    function getAllDishes(){
        $.ajax({
            type : "get",
            url : "/api/v1/groups/"+currentGroupId+"/dishes?token="+token,
            dataType : "json",
            success : function(o){

                if(!iEatUtility.isTokenValid(o)){
                    return false;
                }

                var str = '<ul data-role="listview" data-inset="true" data-filter="true" data-filter-placeholder="Search dish..." class="edit-restaurant-details">';
                $.each(o,function(i,cuisine){
                    str += '<li data-role="list-divider" data-theme="c">'+ cuisine.name+'</li>';
                    $.each(cuisine.dishes,function(index,dish){
                        str += '<li class="cf" data-dish-id="'+dish.id+'">';
                        str += '<span class="dishes-content cf">';
                        str += '<span class="dish-name">'+dish.name+'</span>';
                        str += '<span class="dish-price">'+dish.price+' ￥</span>';
                        str += '</span>';
                        str += '<div class="order-actions cf">';
                        str += '<a class="add" data-inline="true" data-icon="plus" data-role="button" href="javascript:void(0);"> </a>';
                        str += '<input class="number-input" data-inline="true" data-mini="true" type="number" value = "0" />';
                        str += '<a class="reduce" data-inline="true" data-icon="minus" data-role="button" href="javascript:void(0);"> </a>';
                        str += '</div></li>';
                    });
                });
                str += '</ul>';
                $(".edit-my-orders-content").html(str).trigger("create");
                bindFunction();
            },
            error : function(){
                alert("API : /api/v1/groups/:id/dishes is ERROR!");
            }
        });
    }

    function bindFunction() {
        $("#user-order-dishes .edit-restaurant-details .add").bind("click", function (e) {
            var currentInput = $(this).parents("li").find("input.number-input");
            var v = currentInput.val();
            v++;
            currentInput.val(v);
        });
        $("#user-order-dishes .edit-restaurant-details .reduce").bind("click", function () {
            var currentInput = $(this).parents("li").find("input.number-input");
            var v = currentInput.val();
            v--;
            if (v <= 0) {
                v = 0;
            }
            currentInput.val(v);
        });

        $("#user-order-dishes .ui-btn-left").bind("click",function(){
            window.location.href = "/groups/"+currentGroupId;
        });

        $("#user-order-dishes .confirm-foods").bind("click",function(){

            var orderDishes = getMyOrderDishes();
            if(orderDishes.length == 0){
                iEatUtility.msg({
                    type : "error",
                    msg : "您没有点任何餐。"
                });
                return;
            }

            $.ajax({
                type : "post",
                url : "/api/v1/groups/"+currentGroupId+"/orders/create",
                data : {
                    token : token,
                    dishes : JSON.stringify(getMyOrderDishes())
                },
                success : function(o){

                    if(!iEatUtility.isTokenValid(o)){
                        return false;
                    }

                    if(o.status && o.status == "out_of_dueDate"){

                        iEatUtility.msg({
                            type : "error",
                            msg : "你已经超出点餐时间。"
                        });

                        window.setTimeout(function(){
                            window.location.href = "/groups/"+currentGroupId;
                        },2000);

                        return;
                    }
                    $.cookie("orderCreateStatus","success",{ expires: 14, path: '/' });
                    window.location.href = "/groups/"+currentGroupId+"#2";
                },
                error : function(){
                    alert("API : /api/v1/groups/active is ERROR!");
                }
            });
        });

        var $listview = $("#user-order-dishes").find('[data-role="listview"]');
        $listview.append('<li id="no-results" style="display:none;">[No results found]</li>');
        $listview.listview('refresh');
        $("#user-order-dishes").delegate('input[data-type="search"]', 'keyup', function () {
            if ($listview.children(':visible').not('#no-results').length === 0) {
                $('#no-results').show();
            } else {
                $('#no-results').hide();
            }
        });


    }


    function getMyOrderDishes() {
        var result = [];
        $("#user-order-dishes .edit-restaurant-details li.ui-li-static").each(function (index, value) {
            var $value = $(value);
            if ($value.find(".number-input").val() != 0 && $value.data("dish-id")) {
                result.push({
                    "id" : $value.data("dish-id"),
                    "quantity": $value.find(".number-input").val()
                });
            }
        });
        return result;
    }

    function clearCache() {
        $('#user-order-dishes').bind('pagehide', function () {
            $(this).remove();
        });
    }

    function pageInit(f) {
        if(f && typeof f == "function"){
            f();
        }
        iEatUtility.clearLoading($("#user-order-dishes"));
        clearCache();
        getAllDishes();
    }

    return {
        pageInit: pageInit
    }

})();

$(document).bind("pageshow",function(){
    iEatUtility.securityCheck();
    iEatGroupDetails.pageInit();
});
