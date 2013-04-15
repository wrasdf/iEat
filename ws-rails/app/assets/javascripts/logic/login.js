$("#login-page").bind("pageshow", function () {

    iEatUtility.clearLoading($(this));


    function renderMobileVersionInstall(){
        var deviceAgent = iEatUtility.devicesTrack();

        if(deviceAgent == 'iOS'){
            $("#login-page .android-section").remove();
            $("#login-page .install-ul").listview('refresh');
        }else if(deviceAgent == "Android"){
            $("#login-page .ios-section").remove();
            $("#login-page .install-ul").listview('refresh');
        }else{
            $("#login-page .install-ul").remove();
        }
    }

    renderMobileVersionInstall();

    var username = $.cookie("userName") || "";

    $("#input-data").val(username);

    $("#sign-up").parent().bind("click",function(){
        window.location.href = "/users/sign_up";
    });

    $(".login-form").submit(function(e){
        e.preventDefault();
        var data = iEatUtility.escapeHtmlEntities($("#input-data").val());
        var password = iEatUtility.escapeHtmlEntities($("#input-password").val());

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
                    $.cookie('token', o.token,{ expires: 14, path: '/' });
                    $.cookie('userName', o.name,{ expires: 14, path: '/' });
                    $.cookie('userEmail', o.email,{ expires: 14, path: '/' });
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


