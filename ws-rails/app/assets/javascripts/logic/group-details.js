var iEatGroupDetails = (function () {

    function bindFunction() {
        $("#user-order-dishes .edit-restaurant-details .add").bind("click", function (e) {
            var currentInput = $(this).parents("li").find("input.number-input");
            var v = currentInput.val();
            v++;
            currentInput.val(v);
//            refreshMyOrdersUI();
        });
        $("#user-order-dishes .edit-restaurant-details .reduce").bind("click", function () {
            var currentInput = $(this).parents("li").find("input.number-input");
            var v = currentInput.val();
            v--;
            if (v <= 0) {
                v = 0;
            }
            currentInput.val(v);
//            refreshMyOrdersUI();
        });

        $("#user-order-dishes .confirm-foods").bind("click",function(){
            var groupId = $(this).data("id");

            $.mobile.changePage("#group-show");

//            $.post("/groups/"+groupId+"/orders/confirm",{"dishes":getMyOrderDishes()},function(o){
//                if(!o){return}
//                $.mobile.changePage("/success");
//            },"json");

        })
    }

    function showContent() {

        function clearClass() {
            $("#user-order-dishes .footer-navbar a").removeClass("ui-btn-active").removeClass("ui-state-persist");
        }

        function hideAll() {
//            clearClass();
            $("#user-order-dishes .my-orders-content").hide();
            $("#user-order-dishes .my-group-content").hide();
        }

        function bindFooterNavBarClick() {
            $("#user-order-dishes .footer-navbar a.my-status").unbind("click").bind("click", function () {
                hideAll();
                $("#user-order-dishes .my-orders-content").show();
                $('#user-order-dishes').trigger('create');
//                $("#user-order-dishes .footer-navbar a.my-status").addClass("ui-btn-active ui-state-persist");
            });

            $("#user-order-dishes .footer-navbar a.group-status").unbind("click").bind("click", function () {
                hideAll();
                $("#user-order-dishes .my-group-content").show();
//                $("#user-order-dishes .footer-navbar a.group-status").addClass("ui-btn-active ui-state-persist");
            });
        }

        bindFooterNavBarClick();
        $("#user-order-dishes .footer-navbar a.my-status").trigger("click");
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

    function refreshMyOrdersUI() {
        var data = getMyOrderDishes();
        var str = "";
        var totalPrice = 0;
        $.each(data, function (index, value) {
            str += '<li><span class="dish-name">' + value.name + '</span><span class="dish=price">' + value.price + '</span>￥<span class="ui-li-count">' + value.count + '</span></li>';
            totalPrice += value.price * value.count;
        });

        str += '<li><span class="dishes-total">Total:</span><span>' + totalPrice + '</span>￥</li>';
        $("#user-order-dishes .my-order-list").html(str).listview("refresh");
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
        showContent();
        clearCache();
        refreshRestaurantDishesUI();
    }

    return {
        pageInit: pageInit
    }

})();
