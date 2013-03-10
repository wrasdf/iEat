var iEatCreate = (function () {

    function uiPickerInit() {

        $('#timePicker').mobiscroll().time({
            theme: 'iOS',
            display: 'inline',
            mode: 'scroller',
            timeFormat: 'HH:ii',
            onChange: function () {
                setValue(convertUIPickerTime());
            }
        }).scroller('setValue', convertTimeToArray());

        function setValue(str){
            $("#show-Time").html(str);
        }

        setValue(convertUIPickerTime());

    }

    function convertTimeToArray(){
        var result = [];
        var t = new Date();
        var h = t.getHours() + 1;
        var mins = t.getMinutes();

        if(h==24){
            h=0;
        }

        if(h>12){
            result = [h-12,mins,1];
        }else{
            result = [h,mins,0];
        }
        return result;
    }


    function convertUIPickerTime() {
        var selectedValue = $('#timePicker').mobiscroll("getValue");
        var hours = 0;
        var mins = 0;

        if(selectedValue[2] == 1){
            hours = parseInt(selectedValue[0]) + 12;
        }else{
            if(selectedValue[0]<10){
                hours = "0" + selectedValue[0] ;
            }else{
                hours = selectedValue[0];
            }
        }

        if(selectedValue[1] ==0 ){
            mins = "0"+"0";
        }else if(selectedValue[1] < 10){
            mins = "0"+selectedValue[1];
        }else{
            mins = selectedValue[1];
        }

        return hours + ":" + mins;
    }

    function bindEvent() {
        $(".create-group-btn").bind("click", function () {
            var token = $.cookie("token");
            $.ajax({
                type: 'POST',
                url: "/api/v1/groups/create",
                data: {
                    "restaurant_id": $('input[name=radio-choice-v-2]:checked').val(),
                    "name": $("#group-name").val() || "",
                    "due_date": convertUIPickerTime(),
                    "token": token
                },
                success: function (o) {
                    if (o) {
                        var createdGroupId = o.id;
                        $.cookie("currentGroupId", createdGroupId, { expires: 1, path: '/' });
                        $.cookie("groupCreateStatus", "success", { expires: 1, path: '/' });
                        window.location.href = "/groups/" + createdGroupId;
                    }
                },
                error: function (xhr) {
                    iEatUtility.msg({
                        type: "error",
                        msg: $.parseJSON(xhr.responseText).message
                    });
                }
            });
        });

        $(".ui-btn-left").bind("click", function () {
            window.location.href = "/groups";
        });

        $(".more-restaurants").bind("click", function () {
            window.location.href = "/restaurants";
        });

    }

    function pageInit(f) {
        if (f && typeof f == "function") {
            f();
        }
        uiPickerInit();
        bindEvent();

    }

    function selectRadioByRestaurantId(id) {

        if (!id) {
            id = 1;
        }

        var selectors = $("input[name=radio-choice-v-2]");

        selectors.each(function (index, value) {
            var $el = $(value);

            if ($el.val() == id) {
                $el.attr('checked', 'checked');
            } else {
                $el.attr('checked', '');
            }

        });

        selectors.checkboxradio("refresh");
    }

    return {
        pageInit: pageInit,
        selectRadioByRestaurantId: selectRadioByRestaurantId
    }

})();

$(document).bind("pageinit", function () {
    iEatCreate.pageInit();
});

$(window).bind("load", function () {
    var selectedRestaurantId = $.cookie("selectedRestaurantId");
    if (!selectedRestaurantId) {
        selectedRestaurantId = 1;
    }
    iEatCreate.selectRadioByRestaurantId(selectedRestaurantId);
});
