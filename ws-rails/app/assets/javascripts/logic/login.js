$(document).bind("pageinit", function () {
    $("#login-btn").bind("click",function(){
        var email = $("#input-email").val();
        var password = $("#input-password").val();
        $.ajax({
            type : 'POST',
            url : "/api/v1/users/sign_in",
            data : {
                "email" : email,
                "password" : password
            },
            success : function(o){
                if(o.success){
                    $.cookie('token', o.token,{ expires: 10, path: '/' });
                    $.cookie('userName', o.name,{ expires: 10, path: '/' });
                    $.cookie('userEmail', o.email,{ expires: 10, path: '/' });
                    window.location.href="/groups";
                }
            },
            error : function (xhr) {
                iEatUtility.msg({
                    type:"error",
                    msg : $.parseJSON(xhr.responseText).message
                });
            }
        });
    });
});


