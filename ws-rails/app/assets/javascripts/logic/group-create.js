
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

        $(document).undelegate("#group-show", "pageshow").delegate("#group-show", "pageshow", function (e) {
            e.preventDefault();
            iEatGroupShow.pageInit(function(){
                iEatUtility.msg({
                    type : "success",
                    msg : "Your Group is success created."
                });
                $(document).undelegate("#group-show", "pageshow").delegate("#group-show", "pageshow", function (event) {
                    event.preventDefault();
                    iEatGroupShow.pageInit();
                    iEatGroupShow.activeFooterItemByIndex(0);
                });
            });
            iEatGroupShow.activeFooterItemByIndex(0);
        });

        $(document).undelegate("#group-list", "pageshow").delegate("#group-list", "pageshow", function (e) {
            e.preventDefault();
            iEatGroupList.pageInit();
        });


        $(".create-group-btn").bind("click",function(){
            GROUPID = $('input[name=radio-choice-v-2]:checked').val();
            $.mobile.changePage("/groups/"+GROUPID);

        });

        $(document).undelegate("#restaurants-list", "pageshow").delegate("#restaurants-list", "pageshow", function (e) {
            e.preventDefault();
            iEatRestaurant.pageInit();
        });

        $(".more-restaurants").bind("click",function(){
            $.mobile.changePage("/restaurants/list");
        });

    }

    function selectRadioByRestaurantId(id){

        if(!id){
            id = 0;
        }

        var selectors = $("input[name=radio-choice-v-2]");

        selectors.each(function(index,value){
            var $el = $(value);

            if($el.val() == id){
                $el.attr('checked','checked');
            }else{
                $el.attr('checked','');
            }

        });
        selectors.checkboxradio("refresh")

    }

    return {
        pageInit: pageInit,
        selectRadioByRestaurantId : selectRadioByRestaurantId
    }

})();