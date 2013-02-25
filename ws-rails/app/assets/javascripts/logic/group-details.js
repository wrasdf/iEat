var iEatGroupDetails = (function () {

    function reFreshMenuDetailsByData(o) {
        var str = "";
        $.each(o.menu, function (index, value) {
            str += '<li class="cf">';
            str += '<span class="restaurant-content"><span class="dish-name">' + value.dish + '</span><span class="dish-price">' + value.price + '</span>￥</span>';
            str += '<div class="group-button-content" data-role="controlgroup" data-type="horizontal">';
            str += '<a href="" class="reduce" data-role="button" data-icon="minus">&nbsp;</a>';
            str += '<a href="" class="add" data-role="button" data-icon="plus">&nbsp;</a>';
            str += '</div>';
            str += '<input type="number" data-mini="true" class="number-input" value="0"  />';
            str += '</li>';
        });
        $("#user-restaurant-edit .edit-restaurant-details").html(str).listview("refresh");
        bindFunction();
    }

    function bindFunction() {
        $("#user-restaurant-edit .edit-restaurant-details .add").bind("click", function () {
            var currentInput = $(this).parent().parent().parent().find("input.number-input");
            var v = currentInput.val();
            v++;
            currentInput.val(v);
            refreshMyOrdersUI();
        });
        $("#user-restaurant-edit .edit-restaurant-details .reduce").bind("click", function () {
            var currentInput = $(this).parent().parent().parent().find("input.number-input");
            var v = currentInput.val();
            v--;
            if (v <= 0) {
                v = 0;
            }
            currentInput.val(v);
            refreshMyOrdersUI();
        });
    }

    function showContentByData(data) {

        function clearClass() {
            $("#user-restaurant-edit .footer-navbar a").removeClass("ui-btn-active").removeClass("ui-state-persist");
        }

        function hideAll() {
//            clearClass();
            $("#user-restaurant-edit .my-orders-content").hide();
            $("#user-restaurant-edit .my-group-content").hide();
        }

        function bindFooterNavBarClick() {
            $("#user-restaurant-edit .footer-navbar a.my-status").unbind("click").bind("click", function () {
                hideAll();
                $("#user-restaurant-edit .my-orders-content").show();
                reFreshMenuDetailsByData(data.currentRestaurantData);
                $('#user-restaurant-edit').trigger('create');
//                $("#user-restaurant-edit .footer-navbar a.my-status").addClass("ui-btn-active ui-state-persist");
            });

            $("#user-restaurant-edit .footer-navbar a.group-status").unbind("click").bind("click", function () {
                hideAll();
                $("#user-restaurant-edit .my-group-content").show();
//                $('#user-restaurant-edit').trigger('create');
//                $("#user-restaurant-edit .footer-navbar a.group-status").addClass("ui-btn-active ui-state-persist");
            });
        }

        bindFooterNavBarClick();
        $("#user-restaurant-edit .footer-navbar a.my-status").trigger("click");
    }

    function getMyOrderDishes() {
        var result = [];
        $("#user-restaurant-edit .edit-restaurant-details li").each(function (index, value) {
            if ($(value).find(".number-input").val() == 0) {
                return true;
            }
            result.push({
                "name": $(value).find(".dish-name").text(),
                "price": $(value).find(".dish-price").text(),
                "count": $(value).find(".number-input").val()
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
        $("#user-restaurant-edit .my-order-list").html(str).listview("refresh");
    }

    function clearCache() {
        $('#user-restaurant-edit').bind('pagehide', function () {
            $(this).remove();
        });
    }

    function pageInitByData(data) {
        showContentByData(data);
        clearCache();
        $("#user-restaurant-edit h1").html(data.restaurantName);
        $('#user-restaurant-edit').trigger('create');
        $('#user-restaurant-edit .confirm-foods').bind("click", function () {
            $.mobile.changePage("/success");
        })
    }

    return {
        pageInitByData: pageInitByData
    }

})();
