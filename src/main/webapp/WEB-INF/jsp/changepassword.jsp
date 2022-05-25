<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
          integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB"
          crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css"
          integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp"
          crossorigin="anonymous">

    <script src="/resources/js/exif.js"></script>
    <title>Uni-Assistance | Profile</title>

    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <style>
        @media only screen and (min-width: 768px) {
            #formContainer {
                padding-left: 25%;
                padding-right: 25%;
            }
        }

        @media only screen and (max-width: 768px) {
            #formContainer {
            }
        }
    </style>
</head>

<body>
<jsp:include page="include/navbar.jsp"></jsp:include>

<div class="py-5 row">
    <div class="container">
        <div id="alertContainer" style="text-align: center;">

        </div>
    </div>
    <div id="formContainer" class="col-md-12">
        <div class="content">
            <div class="container-fluid">
                <ul class="nav nav-tabs" id="myTab" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" id="nav-password" data-toggle="tab"
                           href="#password" role="tab" aria-controls="password" aria-selected="true"><spring:message
                                code="update.tab.password"/></a>
                    </li>
                </ul>
                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active in" id="password" role="tabpanel" aria-labelledby="password-tab">
                        <form id="passwordForm" method="post" action="/profile/changepassword"
                              data-parsley-validate="true">
                            <div class="form-group row">
                                <label class="col-md-5" for="oldPassword"><spring:message
                                        code="update.oldpassword"/></label>
                                <input type="password" name="oldPassword" class="col-md-7 form-control" id="oldPassword"
                                       data-parsley-trigger="change" data-parsley-minlength="8"
                                       data-parsley-maxlength="12"
                                       required=""/>
                            </div>
                            <div class="form-group row">
                                <label class="col-md-5" for="newPassword"><spring:message
                                        code="update.newpassword"/></label>
                                <input type="password" name="newPassword" class="col-md-7 form-control" id="newPassword"
                                       data-parsley-trigger="change" data-parsley-minlength="8"
                                       data-parsley-maxlength="12"
                                       required=""/>
                            </div>
                            <div class="form-group row">
                                <label class="col-md-5" for="passwordAgain"><spring:message
                                        code="update.againnewpassword"/></label>
                                <input type="password" name="passwordAgain" class="col-md-7 form-control"
                                       id="passwordAgain"
                                       data-parsley-equalto="#newPassword"
                                       data-parsley-trigger="change" data-parsley-minlength="2"
                                       data-parsley-maxlength="12"
                                       required=""/>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <a style="color:white; float:right;" onclick="sendPasswordForm();" id="nextStage"
                                       class="btn btn-primary"><spring:message code="update.submit"/>
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<jsp:include page="include/footer.jsp"></jsp:include>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="/resources/js/jquery.3.2.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
        integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"
        integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T"
        crossorigin="anonymous"></script>
<link rel="stylesheet" href="/resources/css/parsley.css">
<script src="http://parsleyjs.org/dist/parsley.min.js"></script>
<script>
    var successAlert = "<div class=\"row\">\n" +
        "            <div id=\"successAlert\" class=\"alert alert-primary col-md-12\" role=\"alert\">\n" +
        "                <spring:message code='update.success'/>\n" +
        "            </div>\n" +
        "        </div>";
    var failAlert = "<div class=\"row\">\n" +
        "            <div id=\"failAlert\" class=\"alert alert-danger col-md-12\" role=\"alert\">\n" +
        "                <spring:message code='update.failed'/>\n" +
        "            </div>\n" +
        "        </div>";
    var passwordFailAlert = "<div class=\"row\">\n" +
        "            <div id=\"passwordFailAlert\" class=\"alert alert-danger col-md-12\" role=\"alert\">\n" +
        "                <spring:message code='update.password.failed'/>\n" +
        "            </div>\n" +
        "        </div>";

    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
    });

    window.Parsley.addValidator('maxFileSize', {
        validateString: function (_value, maxSize, parsleyInstance) {
            if (!window.FormData) {
                alert('Upgrade your browser!');
                return true;
            }
            var files = parsleyInstance.$element[0].files;
            return files.length != 1 || files[0].size <= maxSize * 1024;
        },
        requirementType: 'integer',
        messages: {
            en: 'This file should not be larger than %s Kb'
        }
    });

    function hideAlerts() {
        if (document.getElementById("successAlert") !== null) {
            document.getElementById("successAlert").remove();
        }
        if (document.getElementById("failAlert") !== null) {
            document.getElementById("failAlert").remove();
        }
        if (document.getElementById("passwordFailAlert") !== null) {
            document.getElementById("passwordFailAlert").remove();
        }
    }

    function sendPasswordForm() {
        hideAlerts();
        var passwordForm = $('#passwordForm');
        if (passwordForm.parsley().validate()) {
            $.ajax({
                type: "POST",
                url: "/profile/changepassword",
                data: passwordForm.serialize(),
                success: function (data) {
                    if (data === "BAD_REQUEST") {
                        document.getElementById("alertContainer").innerHTML = (passwordFailAlert);
                    } else {
                        document.getElementById("alertContainer").innerHTML = (successAlert);
                    }
                },
                error: function (data) {
                    document.getElementById("alertContainer").innerHTML = failAlert;
                }
            });
        }
    }
</script>
<jsp:include page="include/loading.jsp"/>
</body>

</html>