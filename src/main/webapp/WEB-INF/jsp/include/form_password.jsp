<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>

    var wrongAlert = "<div class=\"row\">\n" +
        "            <div id=\"failAlert\" class=\"alert alert-danger col-md-12\" role=\"alert\">\n" +
        "                <spring:message code='update.failed.wrong'/>\n" +
        "            </div>\n" +
        "        </div>";

    function sendPasswordForm() {
        hideAlerts()
        var passwordForm = $('#passwordForm');
        if (passwordForm.parsley().validate()) {
            $.ajax({
                type: "POST",
                url: "/profile/changepassword",
                data: passwordForm.serialize(),
                success: function (data) {
                    if(data === "BAD_REQUEST") {
                        document.getElementById("alertContainer").innerHTML = wrongAlert;
                    } else {
                        document.getElementById("alertContainer").innerHTML = successAlert;
                    }
                },
                error: function (data) {
                    document.getElementById("alertContainer").innerHTML = failAlert;
                }
            });
        }
    }
</script>
<form id="passwordForm" method="post" action="/profile/changepassword" data-parsley-validate="true">
    <input type="hidden" name="dashboard" value="true">
    <input type="hidden" name="userId" value="${user.userId}">
    <div class="form-group row">
        <label class="col-md-3" for="oldPassword"><spring:message code="update.oldpassword" /></label>
        <div class="col-md-5">
            <input type="password" name="oldPassword" class="form-control" id="oldPassword"
                   data-parsley-trigger="change" data-parsley-minlength="8" data-parsley-maxlength="12"
                   required=""/>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-md-3" for="newPassword"><spring:message code="update.newpassword" /></label>
        <div class="col-md-5">
            <input type="password" name="newPassword" class="form-control" id="newPassword"
                   data-parsley-trigger="change" data-parsley-minlength="8" data-parsley-maxlength="12"
                   required=""/>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-md-3" for="passwordAgain"><spring:message code="register.password.again" /></label>
        <div class="col-md-5">
            <input type="password" name="passwordAgain" class="form-control" id="passwordAgain"
                   data-parsley-equalto="#newPassword"
                   data-parsley-trigger="change" data-parsley-minlength="2" data-parsley-maxlength="12"
                   required=""/>
        </div>
    </div>
    <div class="form-group col-md-8" >
        <a href="#" onclick="sendPasswordForm();" class="btn btn-primary" style="margin-left:5px; float:right"><spring:message code="update.submit" /></a>
        <a href="/dashboard/users" class="btn btn-danger" style="float:right"><spring:message code="update.cancel" /></a>

    </div>
</form>