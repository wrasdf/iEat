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