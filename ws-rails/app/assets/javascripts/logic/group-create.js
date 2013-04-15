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
        }else if(h==12){
            result = [1,mins,1];
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

            var groupName = iEatUtility.escapeHtmlEntities($("#group-name").val());

            if(!groupName){
                iEatUtility.msg({
                    type: "error",
                    msg: "Need group name."
                });
                return;
            }

            $.ajax({
                type: 'POST',
                url: "/api/v1/groups/create",
                data: {
                    "restaurant_id": $('input[name=radio-choice-v-2]:checked').val(),
                    "name": groupName,
                    "due_date": convertUIPickerTime(),
                    "token": token
                },
                dataType : "json",
                success: function (o) {

                    if(!iEatUtility.isTokenValid(o)){
                        return false;
                    }

                    if (o) {
                        var createdGroupId = o.id;
                        $.cookie("currentGroupId", createdGroupId, { expires: 14, path: '/' });
                        $.cookie("groupCreateStatus", "success", { expires: 14, path: '/' });
                        if(groupName){
                            $.cookie("createGroupName",groupName, { expires: 14, path: '/' });
                        }
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
            var groupName = $("#group-name").val();
            if(groupName){
                $.cookie("createGroupName",groupName, { expires: 14, path: '/' });
            }
            window.location.href = "/restaurants";
        });

    }

    function getRestaurants(){
        var token = $.cookie("token");
        $.ajax({
            type: 'GET',
            url: "/api/v1/restaurants?token="+token,
            dataType: 'json',
            success: function (o) {

                if(!iEatUtility.isTokenValid(o)){
                    return false;
                }

                if (o) {
                    var selectedRestaurantId = $.cookie("selectedRestaurantId");
                    updateRestaurantsUI(o,selectedRestaurantId);
                }
            },
            error: function (xhr) {
                iEatUtility.msg({
                    type: "error",
                    msg: $.parseJSON(xhr.responseText).message
                });
            }
        });
    }

    var maxLabel = 3;
    function updateRestaurantsUI(data,selectId){
        var str = '<fieldset data-role="controlgroup">';
        str += '<legend>馆子们:</legend>';
        var currentRadioIndex = 0;

        if(selectId){
            $.each(data,function(index,value){
                if(value.id == selectId){
                    str += '<input type="radio" name="radio-choice-v-2" checked="checked" data-id="'+value.id+'" id="radio-choice-'+value.id+'" value="'+value.id+'">';
                    str += '<label for="radio-choice-'+value.id+'">'+value.name+'</label>';
                    return false;
                }
            });
        }


        $.each(data,function(index,value){

            if(selectId && value.id == selectId){
                return true;
            }

            currentRadioIndex ++;

            if(currentRadioIndex > maxLabel){
                return false;
            }

            if(selectId){
                str += '<input type="radio" name="radio-choice-v-2" data-id="'+value.id+'" id="radio-choice-'+value.id+'" value="'+value.id+'">';
            }else{
                if(currentRadioIndex == 1){
                    str += '<input type="radio" name="radio-choice-v-2" checked="checked" data-id="'+value.id+'" id="radio-choice-'+value.id+'" value="'+value.id+'">';
                }else{
                    str += '<input type="radio" name="radio-choice-v-2" data-id="'+value.id+'" id="radio-choice-'+value.id+'" value="'+value.id+'">';
                }
            }
            str += '<label for="radio-choice-'+value.id+'">'+value.name+'</label>';
        });

        str += '</fieldset>';
        $('.radio-content-list').html(str).trigger("create");
    }

    function updateGroupName(str){
        if(str){
            $("#group-name").val(str);
        }
    }


    function pageInit(f) {
        if (f && typeof f == "function") {
            f();
        }
        iEatUtility.clearLoading($("#create-group"));
        updateGroupName($.cookie("createGroupName"));
        getRestaurants();
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

$(document).bind("pageshow", function () {
    iEatUtility.securityCheck();
    iEatCreate.pageInit();
});
