var iEatCreate = (function () {

    function uiPickerInit() {
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

    function convertUIPickerTime() {
        var selectedValue = $('#timePicker').mobiscroll("getValue");
        var hours = selectedValue[0];
        var mins = selectedValue[1];
        if (selectedValue[2] == 1) {
            hours = parseInt(hours) + 12;
        } else if (hours < 10) {
            hours = "0" + hours;
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
