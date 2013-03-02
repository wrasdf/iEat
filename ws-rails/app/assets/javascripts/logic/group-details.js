var iEatGroupDetails = (function () {

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

        $("#user-order-dishes .confirm-foods").bind("click",function(){
            $.mobile.changePage("/groups/"+GROUPID);

//            $.post("/groups/"+groupId+"/orders/confirm",{"dishes":getMyOrderDishes()},function(o){
//                if(!o){return}
//                $.mobile.changePage("/success");
//            },"json");

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
                "name": $value.find(".dish-name").text(),
                "price": parseInt($value.find(".dish-price").text()),
                "count": $value.find(".number-input").val()
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

    function pageInit() {
        clearCache();
        refreshRestaurantDishesUI();
    }

    return {
        pageInit: pageInit
    }

})();
