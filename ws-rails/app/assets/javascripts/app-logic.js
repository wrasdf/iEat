$.mobile.defaultPageTransition = "slidefade";
$.mobile.page.prototype.options.domCache = false;

var RESTAURANTS = null;
var TODAYGROUPLIST = null;

$("#group-list").bind("pageinit", function (e, data) {
    e.preventDefault();
    iEatUtility.getAllRestaurants();
    iEatGroupList.pageInit();
});

var iEatGroupList = (function () {

    function reFreshGroupList() {
        iEatUtility.getTodayGroupList(function (data) {
            var str = '';
            var myGroupsData = data.myGroups;
            for (var i = 0, len = myGroupsData.length; i < len; i++) {
                str += '<li><a href="javascript:void(0);" data-role-type="owner" data-restaurant-name="' + myGroupsData[i].name + '"><span class="restaurant-name">' + myGroupsData[i].name + '</span>Owner : ' + myGroupsData[i].owner + '</a></li>';
            }
            $("#group-list .my-orders-ul").html(str).listview('refresh');

            var str = '';
            var groupListData = data.groupList;
            for (var i = 0, len = groupListData.length; i < len; i++) {
                str += '<li><a href="javascript:void(0);" data-role-type="member" data-restaurant-name="' + groupListData[i].name + '"><span class="restaurant-name">' + groupListData[i].name + '</span>Owner : ' + groupListData[i].owner + '</a></li>';
            }

            $("#group-list .group-list-ul").html(str).listview('refresh');
            groupListClick();
        })
    }

    function groupListClick() {

        $("#group-list .group-list-ul li a,#group-list .my-orders-ul li a").bind("click", function (e) {
            var name = $(e.target).data("restaurant-name");
            var data = {
                currentRestaurantData: iEatUtility.getRestaurantDetailsByName(name),
                type: $(e.target).data("role-type"),
                restaurantName: name
            };

            $(document).undelegate("#user-restaurant-edit", "pageinit").delegate("#user-restaurant-edit", "pageinit", function (e) {
                e.preventDefault();
                iEatGroupDetails.pageInitByData(data);
            })
            $.mobile.changePage("/groups/edit");
        });

        $(document).undelegate("#my-bills", "pageinit").delegate("#my-bills", "pageinit", function (e) {
            e.preventDefault();
            iEatMyBills.pageInit();
        });

        $(document).undelegate("#create-content", "pageinit").delegate("#create-content", "pageinit", function (e) {
            e.preventDefault();
            iEatCreate.pageInit();
        });

        $("#group-list .my-bills-btn").bind("click", function () {
            $.mobile.changePage("/mybills");
        });

        $("#group-list .create-group").bind("click", function () {
            $.mobile.changePage("/create");
        });

    }

    function pageInit() {
        reFreshGroupList()
    }

    return {
        pageInit: pageInit
    }

})();

var iEatGroupDetails = (function () {

    function reFreshMenuDetailsByData(o) {
        var str = "";
        $.each(o.menu, function (index, value) {
            str += '<li class="cf">';
            str += '<span class="restaurant-content"><span class="dish-name">' + value.dish + '</span><span class="dish-price">' + value.price + '</span>￥</span>';
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

    function bindFunction() {
        $("#user-restaurant-edit .edit-restaurant-details .add").bind("click", function () {
            var currentInput = $(this).parent().parent().parent().find("input.number-input");
            var v = currentInput.val();
            v++;
            currentInput.val(v);
            refreshMyOrderUI();
        });
        $("#user-restaurant-edit .edit-restaurant-details .reduce").bind("click", function () {
            var currentInput = $(this).parent().parent().parent().find("input.number-input");
            var v = currentInput.val();
            v--;
            if (v <= 0) {
                v = 0;
            }
            currentInput.val(v);
            refreshMyOrderUI();
        });
    }

    function showContentByData(data) {

        function clearClass() {
            $("#user-restaurant-edit .footer-navbar a").removeClass("ui-btn-active").removeClass("ui-state-persist");
        }

        function resetFooterNavBarByName() {
            var footerStr = '<div data-mini="true" data-role="navbar" class="footer-navbar"><ul><li><a href="javascript:void(0);" class="my-status" data-icon="edit" data-transition="slideup">My Orders</a></li><li><a href="javascript:void(0);" class="group-status" data-role="tab" data-icon="grid" data-transition="slideup">Group Orders</a></li></ul></div>'
            $("#user-restaurant-edit .footer-navbar").html(footerStr);
            clearClass();
        }

        function hideAll() {
            $("#user-restaurant-edit .my-orders-content").hide();
            $("#user-restaurant-edit .my-group-content").hide();
        }

        function bindFooterNavBarClick() {

            $("#user-restaurant-edit .footer-navbar a.my-status").unbind("click").bind("click", function () {
                hideAll();
                $("#user-restaurant-edit .my-orders-content").show();
                reFreshMenuDetailsByData(data.currentRestaurantData);
                window.setTimeout(function () {
                    $("#user-restaurant-edit .footer-navbar a.my-status").addClass("ui-btn-active ui-state-persist");
                }, 500);
            });

            $("#user-restaurant-edit .footer-navbar a.group-status").unbind("click").bind("click", function () {
                hideAll();
                $("#user-restaurant-edit .my-group-content").show();
                window.setTimeout(function () {
                    $("#user-restaurant-edit .footer-navbar a.group-status").addClass("ui-btn-active ui-state-persist");
                }, 500);
            });
        }

        resetFooterNavBarByName();
        bindFooterNavBarClick();

        $("#user-restaurant-edit .footer-navbar a.my-status").trigger("click");

    }

    function getMyOrderGroups() {
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

    function refreshMyOrderUI() {
        var data = getMyOrderGroups();
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
        reFreshMenuDetailsByData: reFreshMenuDetailsByData,
        pageInitByData: pageInitByData
    }

})();


var iEatSuccess = (function () {

    function pageInit() {

    }

    return {
        pageInit: pageInit
    }

})();

var iEatMyBills = (function () {

    function pageInit() {
        bindClickEvent();
    }

    function bindClickEvent() {
        $(document).delegate("#my-bills .my-bills-list li", "click", function () {
            $(document).delegate("#bill-details", "pageinit", function () {
                iEatMyBillDetail.pageInit();
            });
            $.mobile.changePage('/billdetails');
        });
    }

    return {
        pageInit: pageInit
    }

})();

var iEatMyBillDetail = (function () {

    function pageInit() {


        $('.select-all-bills').bind("click", function () {
            $(".checkbox-list input[type='checkbox']").prop("checked", true).checkboxradio("refresh");
        });

        $("#bill-details").trigger("create");
    }

    return {
        pageInit: pageInit
    }

})();


var iEatCreate = (function () {

    function pageInit() {
        $('#timePicker').mobiscroll().time({
            theme: 'iOS',
            display: 'inline',
            mode: 'scroller',
            onChange: function (text, b) {
                setValue(b.values);
            }
        });

        function setValue(array) {
            $("#show-Time").html(array[0] + " : " + (array[1] == 0 ? ("0" + "0") : array[1] < 9 ? "0" + array[1] : array[1]) + (array[2] == 1 ? " PM" : " AM"));
        }

        setValue($('#timePicker').mobiscroll("getValue"));
    }

    return {
        pageInit: pageInit
    }

})();
