var iEatSignUp = (function () {

    function pageInit(f) {
        if(f && typeof f == "function"){
            f();
        }
        bindClickEvent();
    }

    function bindClickEvent() {

    }

    return {
        pageInit: pageInit
    }

})();
iEatSignUp.pageInit();