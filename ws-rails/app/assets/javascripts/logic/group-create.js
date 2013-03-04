
var iEatCreate = (function () {

    function pageInit(f) {
        if(f && typeof f == "function"){
            f();
        }
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

        $(document).undelegate("#user-order-dishes", "pageshow").delegate("#user-order-dishes", "pageshow", function (e) {
            e.preventDefault();
            iEatGroupDetails.pageInit(function(){
                iEatUtility.msg({
                    type : "success",
                    msg : "Your Group is success created."
                });
                $(document).undelegate("#user-order-dishes", "pageshow").delegate("#user-order-dishes", "pageshow", function (event) {
                    event.preventDefault();
                    iEatGroupDetails.pageInit();
                });
            });
        });

        $(document).undelegate("#group-list", "pageshow").delegate("#group-list", "pageshow", function (e) {
            e.preventDefault();
            iEatGroupList.pageInit();
        });


        $(".create-group-btn").bind("click",function(){
            GROUPID = $('input[name=radio-choice-v-2]:checked').val();
            $.mobile.changePage("/groups/"+GROUPID+"/orders/new");

        });

        $(document).undelegate("#restaurants-list", "pageshow").delegate("#restaurants-list", "pageshow", function (e) {
            e.preventDefault();
            iEatRestaurant.pageInit();
        });

        $(".more-restaurants").bind("click",function(){
            $.mobile.changePage("/restaurants/list");
        });


    }

    function selectRadioById(id){

        if(!id){
            id = 0;
        }

        $("input[name=radio-choice-v-2]").each(function(index,value){
            var $el = $(value);
            if($el.val() == id){
                $el.attr('checked',true)
                    .checkboxradio("refresh");
            }else{
                $el.attr('checked',false)
                    .checkboxradio("refresh");
            }
        });

    }

    return {
        pageInit: pageInit,
        selectRadioById : selectRadioById
    }

})();