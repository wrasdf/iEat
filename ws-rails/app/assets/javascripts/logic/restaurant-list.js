var iEatRestaurant = (function(){

    function pageInit(){
        console.log(1111);
        $(".ui-btn-left").bind("click",function(){
            window.location.href = "/groups/new";
        });

        $(".restaurant-list-content li a").unbind("click").bind("click",function(){
            $.cookie("selectedRestaurantId",$(this).data("id"),{ expires: 1, path: '/' });
            window.location.href = "/groups/new";
        });


        var $listview = $("#restaurants-list").find('.restaurant-list-content');
        $listview.append('<li id="no-results" style="display:none;">[No results found]</li>');
        $listview.listview('refresh');

        $("#restaurants-list").delegate('input[data-type="search"]', 'keyup', function () {
            if ($listview.children(':visible').not('#no-results').length === 0) {
                $('#no-results').show();
            } else {
                $('#no-results').hide();
            }
        });

    }

    return {
        pageInit : pageInit
    }

})();

$(document).bind("pageshow",function(){
    iEatRestaurant.pageInit();
});