$.mobile.defaultPageTransition = "slidefade";
$.mobile.page.prototype.options.domCache = false;

var RESTAURANTS = null;
var TODAYGROUPLIST = null;

$("#group-list").bind("pageinit", function (e, data) {
    e.preventDefault();
    iEatUtility.getAllRestaurants();
    iEatGroupList.pageInit();
});






