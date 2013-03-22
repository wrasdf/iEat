$(document).bind("pageinit", function () {

    iEatUtility.clearCookie();

    $.get("/users/sign_out");

    var username = $.cookie("userName") || "";
    $("#input-data").val(username);

    $("#sign-up").bind("click",function(){
        window.location.href = "/users/sign_up";
    });

    $(".login-form").submit(function(e){
        e.preventDefault();
        var data = $("#input-data").val();
        var password = $("#input-password").val();

        $.mobile.pageLoadErrorMessage = false;

        $.mobile.loading( 'show', {
            text: 'Loading',
            textVisible: true,
            theme: 'a',
            html: ""
        });

        $.ajax({
            type : 'POST',
            url : "/api/v1/users/sign_in",
            data : {
                "data" : data,
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


