
var iEatGroupDetails = (function () {

    var currentGroupId = $.cookie("currentGroupId");
    var token = $.cookie("token");

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
                success : function(){
                    $.cookie("orderCreateStatus","success",{ expires: 1, path: '/' });
                    window.location.href = "/groups/"+currentGroupId+"#2";
                },
                error : function(){
                    alert("API : /api/v1/groups/active is ERROR!");
                }
            });

        })
    }


    function getMyOrderDishes() {
        var result = [];
        $("#user-order-dishes .edit-restaurant-details li.ui-li-static").each(function (index, value) {
            var $value = $(value);
            if ($value.find(".number-input").val() == 0) {
                return true;
            }
            result.push({
                "id" : $value.data("dish-id"),
                "quantity": $value.find(".number-input").val()
            });

        });
        return result;
    }

    function clearCache() {
        $('#user-order-dishes').bind('pagehide', function () {
            $(this).remove();
        });
    }

    function refreshRestaurantDishesUI(){
        $("#user-order-dishes .edit-restaurant-details").listview("refresh");
        $('#user-order-dishes').trigger('create');
        bindFunction();
    }

    function pageInit(f) {
        if(f && typeof f == "function"){
            f();
        }
        clearCache();
        refreshRestaurantDishesUI();
    }

    return {
        pageInit: pageInit
    }

})();

$(document).bind("pageshow",function(){
    iEatGroupDetails.pageInit();

});
