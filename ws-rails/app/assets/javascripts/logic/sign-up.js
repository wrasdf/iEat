var iEatSignUp = (function () {

    function pageInit(f) {
        if(f && typeof f == "function"){
            f();
        }
        iEatUtility.clearCookie();
        bindClickEvent();
    }

    function bindClickEvent() {

        $(".register-form").bind("submit",function(e){
            e.preventDefault();
            var name = $("#input-username").val();
            var email = $("#input-email").val();
            var tel = $("#input-telephone").val();
            var password = $("#input-password").val();
            var confirmPassword = $("#input-password-confirmation").val();

            $.ajax({
                type : 'POST',
                url : "/api/v1/users",
                data : {
                    "name" : name,
                    "email" : email,
                    "telephone" : tel || "",
                    "password" : password,
                    "password_confirmation" : confirmPassword
                },
                dataType: "json",
                success : function(o){
                    if(o){
                        $.cookie('userName', o.name,{ expires: 10, path: '/' });
                        $.cookie('userEmail', o.email,{ expires: 10, path: '/' });
                        window.location.href="/users/sign_in";
                    }
                },
                error : function (xhr) {
                    var errors = $.parseJSON(xhr.responseText)["errors"];
                    var errorsArray = [];
                    var messages;
                    for(var i in errors){
                        errorsArray.push(i + " " + errors[i][0]);
                    }
                    messages = errorsArray.join(" and ");
                    iEatUtility.msg({
                        type:"error",
                        msg : messages
                    });
                }
            });
            return false;

        });
    }

    return {
        pageInit: pageInit
    }

})();

$(document).bind("pageshow",function(){
    iEatSignUp.pageInit();
});

