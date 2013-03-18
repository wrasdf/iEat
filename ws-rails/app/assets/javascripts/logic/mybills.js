var iEatMyBills = (function () {

    function pageInit(f) {
        if(f && typeof f == "function"){
            f();
        }
        bindClickEvent();
    }

    function bindClickEvent() {
        $("#my-bills .ui-btn-left").bind("click",function(){
            window.location.href = "/groups";
        });
    }

    return {
        pageInit: pageInit
    }

})();
iEatMyBills.pageInit();