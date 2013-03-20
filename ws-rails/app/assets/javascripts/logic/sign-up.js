var iEatSignUp = (function () {

    function pageInit(f) {
        if(f && typeof f == "function"){
            f();
        }
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
                    "telephone" : tel,
                    "password" : password,
                    "password_confirmation" : confirmPassword
                },
                success : function(o){
                    console.log(o);
//                    if(o.success){
//                        $.cookie('token', o.token,{ expires: 10, path: '/' });
//                        $.cookie('userName', o.name,{ expires: 10, path: '/' });
//                        $.cookie('userEmail', o.email,{ expires: 10, path: '/' });
//                        window.location.href="/groups";
//                    }
//                    alert(o);
//                    window.location.href="/users/sign_in";
                },
                error : function (xhr) {
                    iEatUtility.msg({
                        type:"error",
                        msg : $.parseJSON(xhr.responseText).message
                    });
                }
            });

        });
    }

    return {
        pageInit: pageInit
    }

})();
iEatSignUp.pageInit();