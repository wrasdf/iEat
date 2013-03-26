var iEatMyBills = (function () {

    function pageInit(f) {
        if(f && typeof f == "function"){
            f();
        }
        bindClickEvent();
        initStatusByHash();
    }

    function initStatusByHash(){
        var triggerIndex = location.hash.replace("#", "") ;
        if (!triggerIndex) {
            triggerIndex = 0;
        }
        iEatMyBills.activeFooterItemByIndex(triggerIndex);
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

$("#my-bills").bind("pageshow",function(){
    iEatMyBills.pageInit();
});
