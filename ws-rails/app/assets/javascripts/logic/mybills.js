var iEatMyBills = (function () {
    var token = $.cookie("token");
    function pageInit(f) {
        if(f && typeof f == "function"){
            f();
        }
        iEatUtility.clearLoading($("#my-bills"));
        renderPageUI();
    }

    function initStatusByHash(){
        var triggerIndex = location.hash.replace("#", "") ;
        if (!triggerIndex) {
            triggerIndex = 0;
        }
        iEatMyBills.activeFooterItemByIndex(triggerIndex);
    }

    function renderGetMoneyBackUI(data){
        var str = getListViewDomStrByData(data,"getMoneyBack");
        $(".get-money-back-content ul").html(str).listview("refresh");
    }

    function renderPaybackUI(data){
        var str = getListViewDomStrByData(data,"payback");
        $(".pay-back-content ul").html(str).listview("refresh");
    }

    function dateFormat(date){
        var dateObj = new Date(date);
        var _date = dateObj.getDate();
        var _month = dateObj.getMonth() + 1; //Months are zero based
        var _year = dateObj.getFullYear();

        return _year + "-" + _month + "-"+ _date;
    }

    function getListViewDomStrByData(data,renderType){

        if(data.length == 0){
            return '<li><span class="no-item">没有欠款哦。</span></li>';
        }

        var str = '';

        $.each(data,function(index,item){
            var totalPrice = 0;
            if(renderType == "getMoneyBack"){
                str += '<li><h3><span class="bills-title">'+dateFormat(item.created_at) +'  '+ iEatUtility.escapeHtmlEntities(item.user.name)+'</span><button data-order-id="'+item.id+'" class="mark-paid" data-mini="true" data-inline="true">删除</button></h3>';
            }else{
                str += '<li><h3><span class="data">'+dateFormat(item.created_at) +'</span><span class="info">&nbsp;'+iEatUtility.escapeHtmlEntities(item.group.user.name)+'</span></h3>';
            }
            str += '<table>';
            $.each(item.order_dishes,function(i,order){
                str += '<tr>';
                str += '<td class="dish-name">'+order.name+'</td>';
                str += '<td class="dish-price">'+order.price+' ￥</td>';
                str += '<td class="dish-count"><div class="dish-count"><span class="ui-li-count ui-btn-up-c ui-btn-corner-all">'+order.quantity+'</span></div></td>';
                str += '</tr>';
                totalPrice += order.price * order.quantity;
            });
            str += '<tr><td class="dish-name">总计</td><td class="dish-price">'+totalPrice+' ￥</td><td class="dish-count"></td></tr>';
            str += '</table></li>';
        });
        return str;
    }

    function renderPageUI(){

        $.ajax({
            type : 'GET',
            url : "/api/v1/mybills",
            data : {
                "token" : token
            },
            dataType : "json",
            success : function(o){

                if(!iEatUtility.isTokenValid(o)){
                    return false;
                }

                renderGetMoneyBackUI(o.unpaid_orders);
                renderPaybackUI(o.payback_orders);
                $("#my-bills").trigger("create");
                bindClickEvent();
                initStatusByHash();
            },
            error : function (xhr) {
                iEatUtility.msg({
                    type:"error",
                    msg : $.parseJSON(xhr.responseText).message
                });
            }
        });

    }

    function bindClickEvent() {

        $("#my-bills .ui-btn-left").bind("click",function(){
            window.location.href = "/groups";
        });

        function hideTabViewContent(){
            $(".get-money-back-content").hide();
            $(".pay-back-content").hide();
            $(".get-money-back-tab").removeClass("ui-btn-active");
            $(".pay-back-tab").removeClass("ui-btn-active");
        }

        $("#my-bills .get-money-back-tab").bind("click",function(){
            var self = this;
            hideTabViewContent();
            $(".get-money-back-content").show();
            window.location.hash = "#0";
            window.setTimeout(function(){
                $(self).addClass("ui-btn-active");
            },0)
        });

        $("#my-bills .pay-back-tab").bind("click",function(){
            var self = this;
            hideTabViewContent();
            $(".pay-back-content").show();
            window.location.hash = "#1";
            window.setTimeout(function(){
                $(self).addClass("ui-btn-active");
            },0)
        });

        $(".mark-paid").bind("click",function(){
            var orderId = $(this).data("order-id");
            var self = this;
            $.ajax({
                type : 'GET',
                url : "/api/v1/mybills/paid/"+orderId,
                data : {
                    "token" : token
                },
                dataType : "json",
                success : function(o){
                    $(self).parents("li").remove();
                },
                error : function (xhr) {
                    iEatUtility.msg({
                        type:"error",
                        msg : $.parseJSON(xhr.responseText).message
                    });
                }
            });
        });

    }

    function activeFooterItemByIndex(index){

        if (index == 0) {
            $("#my-bills .get-money-back-tab").trigger("click");
        }

        if (index == 1) {
            $("#my-bills .pay-back-tab").trigger("click");
        }
    }

    return {
        pageInit: pageInit,
        activeFooterItemByIndex : activeFooterItemByIndex
    }

})();

$("#my-bills").bind("pageinit",function(){
    iEatUtility.securityCheck();
    iEatMyBills.pageInit();
});
