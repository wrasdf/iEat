var iEatGroupShow = (function () {

    var urlRegexp = /^.+groups\/(\d+)(#?)/g;
    var currentGroupId = urlRegexp.exec(window.location.href)[1];
    var token = $.cookie("token");
    var userName = $.cookie("userName");
    var setIntervalForDeleteButton = null;

    function pageInit(f) {

        if (f && typeof f == "function") {
            f();
        }

        iEatUtility.clearLoading($("#group-show"));
        rebuildGroupDetailsPage();

        $("#group-show .restaurant-info-btn").bind("click", function () {
            var self = this;
            $("#group-show .details-content").hide();
            $("#group-show .group-details").show();
            window.location.hash = "#0";
            window.setTimeout(function(){
                $(self).addClass("ui-btn-active");
            },0);
        });

        $("#group-show .all-info-btn").bind("click", function () {
            var self = this;
            $("#group-show .details-content").hide();
            $("#group-show .all-status").show();
            window.location.hash = "#1";
            window.setTimeout(function(){
                $(self).addClass("ui-btn-active");
            },0);
        });

        $("#group-show .my-orders-btn").bind("click", function () {
            var self = this;
            $("#group-show .details-content").hide();
            $("#group-show .my-orders-details").show();
            window.location.hash = "#2";
            window.setTimeout(function(){
                $(self).addClass("ui-btn-active");
            },0);
        });

        $("#group-show .members-orders-btn").bind("click", function () {
            var self = this;
            $("#group-show .details-content").hide();
            $("#group-show .members-details").show();
            window.location.hash = "#3";
            window.setTimeout(function(){
                $(self).addClass("ui-btn-active");
            },0);
        });


        $("#group-show .ui-btn-left").bind("click", function () {
            window.location.href = "/groups";
        });

    }

    function rebuildGroupDetailsPage(){
        getGroupDetails(function (group) {
            updateGroupInfoDetails(group);
            updateRestaurantDetails(group.restaurant);
            updateMyStatus(group.orders);
            updateOthersStatus(group.orders);
            updateAllStatus(group.orders);
            initStatusByHash();
            dueDateActions(group)
        });
    }



    function dueDateActions(data){

        function isOutOfDueDate(){
            var dueDate = new Date(data.due_date).getTime();
            var currentTime = new Date().getTime();
            return currentTime - dueDate > 0;
        }

        function hideOutOfDueDateButtons(isShowMsg){

            if(isOutOfDueDate()){

                $(".buy-foods").hide();
                $(".my-orders-details li .ui-btn").hide();

                if(isShowMsg){
                    iEatUtility.msg({
                        type: "error",
                        msg: "Out of this group's due date."
                    });
                }

            }
        }

        $("#group-show .my-orders-details li .ui-btn").unbind("click").bind("click",function(){

            if(isOutOfDueDate()){
                hideOutOfDueDateButtons(true);
                return false;
            }

            var orderId = $(this).find('button').data("order-id");
            $.ajax({
                type: "get",
                url: "/api/v1/orders/delete/" + orderId + "?token=" + token,
                dataType: "json",
                success: function (data) {

                    if(!iEatUtility.isTokenValid(data)){
                        return false;
                    }

                    if (data && data.status == 'success') {
                        if(setIntervalForDeleteButton){
                            window.clearInterval(setIntervalForDeleteButton);
                            setIntervalForDeleteButton = null;
                        }
                        rebuildGroupDetailsPage();
                    }
                },
                error: function () {
                    alert("API : /api/v1/orders/delete/:id is ERROR!");
                }
            });
        });

        $("#group-show .buy-foods").bind("click", function () {
            if(isOutOfDueDate()){
                hideOutOfDueDateButtons(true);
                return false;
            }
            var currentGroupId = $.cookie("currentGroupId");
            window.location.href = "/groups/" + currentGroupId + "/orders/new";
        });

        hideOutOfDueDateButtons();

    }

    function initStatusByHash(){
        var triggerIndex = location.hash.replace("#", "") ;
        if (!triggerIndex) {
            triggerIndex = 0;
        }
        iEatGroupShow.activeFooterItemByIndex(triggerIndex);
    }

    function updateRestaurantDetails(restaurantData) {
        var str = '<li><span class="subject">饭店名称</span><span>' + restaurantData.name + '</span></li>';
        str += '<li><span class="subject">订餐电话</span><span>' + restaurantData.telephone + '</span></li>';
        str += '<li><span class="subject">餐馆地址</span><span>' + restaurantData.address + '</span></li>';
        if(restaurantData.note){
            str += '<li><span class="subject">备注</span><span>' + (restaurantData.note || "") + '</span></li>';
        }
        $("#group-show .restaurant-details").html(str).listview('refresh').show();
    }

    function updateGroupInfoDetails(group) {

        var str = '<li><span class="subject">团名</span><span>' + iEatUtility.escapeHtmlEntities(group.name) + '</span></li>';
        str += '<li><span class="subject">Owner</span><span>' + iEatUtility.escapeHtmlEntities(group.owner.name) + '</span></li>';
        str += '<li><span class="subject">电话:</span><span>' + (group.owner.telephone || "暂时没有")  + '</span></li>';
        str += '<li><span class="subject">截止时间:</span><span>' + new Date(group.due_date).format("isoDateTime");  + '</span></li>';
        $("#group-show .current-group-details").html(str).listview('refresh').show();
    }

    function generateOrderItemStrByOrderData(data,editStatus) {
        var total = 0;
        if(editStatus){
            var str = '<li><h2><span class="user-name">' + iEatUtility.escapeHtmlEntities(data.user.name) + '</span><button data-order-id="'+data.id+'" data-mini="true" data-inline="true" data-disabled="false">删除</button></h2><table><tbody>';
        }else{
            var str = '<li><h2>' + data.user.name + '</h2><table><tbody>';
        }

        $.each(data.order_dishes, function (index, value) {
            str += '<tr><td class="dish-name">' + value.name + '</td>';
            str += '<td class="dish-price">' + value.price + ' ￥</td>';
            str += '<td class="dish-count">';
            str += '<div class="dish-count">';
            str += '<span class="ui-li-count">' + value.quantity + '</span>';
            str += '</div>';
            str += '</td></tr>';
            total += parseFloat(value.price) * parseInt(value.quantity);
        });
        str += '<tr><td class="dish-name">总计</td><td class="dish-price">' + total + ' ￥</td><td></td></tr></tbody></table>';
        str += '</li>';
        return str;
    }

    function refactorOrders(orders) {
        var myOrdersList = [];
        var othersList = [];
        var allStatus = [];

        $.each(orders, function (index, value) {
            if (value.order_dishes.length > 0) {
                if (value.user.name == userName) {
                    myOrdersList.push(value);
                } else {
                    othersList.push(value);
                }
            }
        });

        function addToAllStatus(data) {

            if (allStatus.length == 0) {
                allStatus.push(data);
            } else {
                var canBeInsert = true;
                $.each(allStatus, function (index, order) {
                    if (order.name == data.name) {
                        order.quantity += data.quantity;
                        canBeInsert = false;
                        return true;
                    }
                });
                if (canBeInsert) {
                    allStatus.push(data);
                }
            }
        }

        $.each(orders, function (index, order) {
            $.each(order.order_dishes, function (i, item) {
                var eachOrder = {
                    name: item.name,
                    price: item.price,
                    quantity: item.quantity
                };
                addToAllStatus(eachOrder);
            });
        });

        return {
            myOrders: myOrdersList,
            otherOrders: othersList,
            allStatus: allStatus
        }
    }

    function updateMyStatus(orders) {
        var str = "";
        var myOrders = refactorOrders(orders).myOrders;

        if (myOrders.length == 0) {
            str = '<li class="no-orders">当前您没有订餐。</li>';
        } else {

            $.each(myOrders, function (index, value) {
                str += generateOrderItemStrByOrderData(value,true);
            });
        }

        $(".my-orders-details .order-status").html(str).listview("refresh");
        $("#group-show").trigger("create");
    }

    function updateOthersStatus(orders) {
        var str = "";
        var otherOrders = refactorOrders(orders).otherOrders;

        if (otherOrders.length == 0) {
            str = '<li class="no-orders">当前没有其他人订餐。</li>';
        } else {
            $.each(otherOrders, function (index, value) {
                str += generateOrderItemStrByOrderData(value);
            });
        }
        $(".members-details .order-status").html(str).listview("refresh");
    }

    function updateAllStatus(orders) {
        var str = "";
        var allStatus = refactorOrders(orders).allStatus;
        var total = 0;
        if (allStatus.length == 0) {
            str += '<li class="no-orders">当前没有其他人订餐</li>';
        } else {
            str += '<li><table><tbody>';
            $.each(allStatus, function (index, order) {
                str += '<tr>';
                str += '<td class="dish-name">' + order.name + '</td>';
                str += '<td class="dish-price">' + order.price + ' ￥</td>';
                str += '<td class="dish-count"><div class="dish-count"><span class="ui-li-count">' + order.quantity + '</span></div></td>';
                str += '</tr>';
                total += parseFloat(order.price) * parseInt(order.quantity);
            });
            str += '<tr>';
            str += '<td class="dish-name">总计</td>';
            str += '<td class="dish-price">' + total + ' ￥</td>';
            str += '<td class="dish-count"></td>';
            str += '</tr>';
            str += '</tbody></table></li>';
        }
        $(".all-status .order-status").html(str).listview("refresh");
    }

    function activeFooterItemByIndex(n) {
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
    }

    function getGroupDetails(callback) {

        $.ajax({
            type: "get",
            url: "/api/v1/groups/" + currentGroupId + "?token=" + token,
            dataType: "json",
            success: function (data) {
                if(!iEatUtility.isTokenValid(data)){
                    return false;
                }
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

$("#group-show").bind("pageshow", function () {
    iEatUtility.securityCheck();
    if ($.cookie("orderCreateStatus") == "success") {
        iEatUtility.msg({
            type: "success",
            msg: "Your order is success created."
        });
        $.cookie("orderCreateStatus", "null", { expires: 14, path: '/' });
    }

    if ($.cookie("groupCreateStatus") == "success") {
        iEatUtility.msg({
            type: "success",
            msg: "Your Group is success created."
        });
        $.cookie("groupCreateStatus", "null", { expires: 14, path: '/' });
    }
    iEatGroupShow.pageInit();
});



