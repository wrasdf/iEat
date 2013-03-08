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
                    $.cookie('token', o.token);
                    $.cookie('userName', o.name);
                    $.cookie('userEmail', o.email);
                    window.location.href="/groups";
                }
            },
            error : function (xhr) {
                console.log(xhr)
                iEatUtility.msg({
                    type:"error",
                    msg : $.parseJSON(xhr.responseText).message
                });
            }
        });
    });
});


