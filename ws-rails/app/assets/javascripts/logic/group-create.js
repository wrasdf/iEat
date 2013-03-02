
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

        $(document).undelegate("#user-order-dishes", "pageinit").delegate("#user-order-dishes", "pageinit", function (e) {
            e.preventDefault();
            iEatGroupDetails.pageInit();
        });

        $(document).undelegate("#group-list", "pageinit").delegate("#group-list", "pageinit", function (e) {
            e.preventDefault();
            iEatGroupList.pageInit();
        });

//        $(".ui-btn-right").bind("click",function(){
//            var groupId = $('input[name=radio-choice-v-2]:checked').val();
//            $.mobile.changePage("/groups/"+groupId+"/orders/new");
//        });

        $(".order-my-dishes").bind("click",function(){
            $.mobile.changePage("/groups");
        });

    }

    return {
        pageInit: pageInit
    }

})();