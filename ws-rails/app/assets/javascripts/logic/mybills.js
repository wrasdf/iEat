var iEatMyBills = (function () {

    function pageInit(f) {
        if(f && typeof f == "function"){
            f();
        }
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
