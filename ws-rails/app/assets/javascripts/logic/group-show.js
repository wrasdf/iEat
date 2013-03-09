var iEatGroupShow = (function () {

    var currentGroupId = $.cookie("currentGroupId");
    var token = $.cookie("token");
    var userName = $.cookie("userName");

    function pageInit(f) {

        if (f && typeof f == "function") {
            f();
        }

        getGroupDetails(function (group) {
            updateGroupName(group.name);
            updateRestaurantDetails(group.restaurant);
            updateMyStatus(group.orders);
            updateOthersStatus(group.orders);
        });

        $("#group-show .restaurant-info-btn").bind("click", function () {
            $("#group-show .details-content").hide();
            $("#group-show .group-details").show();
        });

        $("#group-show .all-info-btn").bind("click", function () {
            $("#group-show .details-content").hide();
            $("#group-show .all-status").show();
        });

        $("#group-show .my-orders-btn").bind("click", function () {
            $("#group-show .details-content").hide();
            $("#group-show .my-orders-details").show();
        });

        $("#group-show .members-orders-btn").bind("click", function () {
            $("#group-show .details-content").hide();
            $("#group-show .members-details").show();
        });

        $("#group-show .buy-foods").bind("click", function () {
            var currentGroupId = $.cookie("currentGroupId");
            window.location.href = "/groups/" + currentGroupId + "/orders/new";
        });

        $("#group-show .ui-btn-left").bind("click", function () {
            window.location.href = "/groups";
        });

    }

    function updateRestaurantDetails(restaurantData) {
        var str = '<li><span class="subject">饭店名称</span><span>' + restaurantData.name + '</span></li>';
        str += '<li><span class="subject">订餐电话</span><span>' + restaurantData.telephone + '</span></li>';
        str += '<li><span class="subject">餐馆地址</span><span>' + restaurantData.address + '</span></li>';
        $("#group-show .restaurant-details").html(str).listview('refresh').show();
    }

    function updateGroupName(groupName) {
        $(".group-name").html(groupName);
    }

    function generateOrderItemStrByOrderData(data) {
        var total = 0;
        var str = '<li><h2>王锐</h2><table><tbody>';
        $.each(data, function (index, value) {
            str += '<tr><td class="dish-name">' + value.dish.name + '</td>';
            str += '<td class="dish-price">' + value.dish.price + '</td>';
            str += '<td class="dish-count">';
            str += '<div class="dish-count">';
            str += '<span class="ui-li-count">' + value.quantity + '</span>';
            str += '</div>';
            str += '</td></tr>';
            total += parseFloat(value.dish.price) * parseInt(value.quantity);
        });
        str += '<tr><td class="dish-name">总计</td><td class="dish-price">' + total + '$</td><td></td></tr></tbody></table>';
        str += '</li>';
        return str;
    }

    function refactorOrders(orders){
        var myOrdersList = [];
        var othersList = [];
        $.each(orders, function (index, value) {
            if (value.order_dishes.length > 0) {
                if(value.user.name == userName){
                    myOrdersList.push(value.order_dishes);
                }else{
                    othersList.push(value.order_dishes);
                }
            }
        });
        return {
            myOrders : myOrdersList,
            otherOrders : othersList
        }
    }



    function updateMyStatus(orders) {
        var str = "";
        var myOrders = refactorOrders(orders).myOrders;

        if (myOrders.length == 0) {
            str = "<li>当前您没有订餐。</li>";
        }else{

            $.each(myOrders, function (index, value) {
                str += generateOrderItemStrByOrderData(value);
            });
        }
        $(".my-orders-details .order-status").html(str).listview("refresh");
    }

    function updateOthersStatus(orders){
        var str = "";
        var otherOrders = refactorOrders(orders).otherOrders;

        if (otherOrders.length == 0) {
            str = "<li>当前没有其他人没有订餐。</li>";
        }else{
            $.each(otherOrders, function (index, value) {
                str += generateOrderItemStrByOrderData(value);
            });
        }
        $(".members-details .order-status").html(str).listview("refresh");
    }

    function updateAllStatus(orders){
        var str = "";
        if(orders.length == 0){
            str += "当前没有其他人没有订餐";
        }else{

        }


//
//        <table>
//            <tbody><tr>
//                <td class="dish-name">小炒肉</td>
//                <td class="dish-price">12$</td>
//                <td class="dish-count">
//                    <div class="dish-count">
//                        <span class="ui-li-count ui-btn-up-c ui-btn-corner-all">4</span>
//                    </div>
//                </td>
//            </tr>
//                <tr>
//                    <td class="dish-name">蒙面</td>
//                    <td class="dish-price">12$</td>
//                    <td class="dish-count">
//                        <div class="dish-count">
//                            <span class="ui-li-count ui-btn-up-c ui-btn-corner-all">4</span>
//                        </div>
//                    </td>
//                </tr>
//                <tr>
//                    <td class="dish-name">总计</td>
//                    <td class="dish-price">245$</td>
//                    <td></td>
//                </tr>
//            </tbody></table>


        $(".members-details .order-status").html(str).listview("refresh");
    }


    function activeFooterItemByIndex(n) {
        window.setTimeout(function () {
            if (n == 0) {
                $("#group-show .restaurant-info-btn").trigger("click");
            }

            if (n == 1) {
                $("#group-show .all-info-btn").trigger("click");
            }

            if (n == 2) {
                $("#group-show .my-orders-btn").trigger("click");
            }

            if (n == 3) {
                $("#group-show .members-orders-btn").trigger("click");
            }
        }, 10);
    }

    function getGroupDetails(callback) {

        $.ajax({
            type: "get",
            url: "/api/v1/groups/" + currentGroupId + "?token=" + token,
            dataType: "json",
            success: function (data) {
                if (data) {
                    if (callback) {
                        callback(data);
                    }
                }
            },
            error: function () {
                alert("API : /api/v1/groups/:id is ERROR!");
            }
        });
    }

    return {
        pageInit: pageInit,
        activeFooterItemByIndex: activeFooterItemByIndex
    }

})();

$("#group-show").bind("pageinit", function () {
//    if(currentGroupId){
//        iEatUtility.msg({
//            type : "success",
//            msg : "Your Group is success created."
//        });
//    }
    iEatGroupShow.pageInit();

});

$(window).bind("load", function () {
    iEatGroupShow.activeFooterItemByIndex(0);
});