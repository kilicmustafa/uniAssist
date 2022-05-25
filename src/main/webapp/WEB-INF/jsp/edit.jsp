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
    <script>
        var userForm, passwordForm, applicationForm;


        function userSettings() {
            if (document.getElementById("appForm") !== null) {
                document.getElementById("appForm").remove();
            }

            if (document.getElementById("userForm") === null) {
                document.getElementById("user").appendChild(userForm);
            }
        }

        function fileSettings() {
            if (document.getElementById("userForm") !== null) {
                document.getElementById("userForm").remove();
            }

            if (document.getElementById("appForm") === null) {
                document.getElementById("application").appendChild(applicationForm);
            }
        }

        window.onload = function () {
            userForm = document.getElementById("userForm");
            applicationForm = document.getElementById("appForm");
            passwordForm = document.getElementById("passwordForm");

            if (document.getElementById("appForm") !== null) {
                document.getElementById("appForm").remove();
            }

            if (document.getElementById("applicationStateForm") !== null) {
                document.getElementById("applicationStateForm").remove();
            }
        }
    </script>
</head>

<body>
<jsp:include page="include/navbar.jsp"></jsp:include>

<div class="py-5 row">
    <jsp:include page="include/adsleft.jsp" />

    <div id="formContainer" class="col-md-6">
        <div class="container">
            <div id="alertContainer" style="text-align: center;">

            </div>
        </div>
        <div class="content">
            <div class="container-fluid">
                <ul class="nav nav-tabs" id="myTab" role="tablist" style="margin-bottom: 25px;">
                    <li class="nav-item">
                        <a onclick="userSettings();" class="nav-link active" id="nav-user" data-toggle="tab"
                           href="#user" role="tab" aria-controls="user" aria-selected="true"><spring:message
                                code="update.tab.usersettings"/></a>
                    </li>
                    <li class="nav-item">
                        <a onclick="fileSettings();" class="nav-link" id="nav-application" data-toggle="tab"
                           href="#application" role="tab" aria-controls="application"
                           aria-selected="false"><spring:message code="update.tab.application"/></a>
                    </li>
                </ul>
                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active in" id="user" role="tabpanel" aria-labelledby="user-tab">
                        <style>
                            @media only screen and (max-width: 768px) {
                                #photoContainer {
                                    display:flex;
                                }
                            }

                            @media only screen and (min-width: 768px) {
                                #photoContainer {
                                    display: block;
                                }
                            }
                        </style>
                        <form id="userForm" action="/profile/update" method="post" enctype="multipart/form-data"
                              data-parsley-validate="true">
                            <input type="hidden" name="userId" value="${user.userId}">
                            <div id="photoContainer" class="form-group row">
                                <div style="float:right !important;" class="col-md-3">
                                    <img id="profile-photo" class="img-circle" width="125" height="150"
                                         src="<c:choose>
                                                <c:when test='${photoDocument eq null or photoDocument.documentFileName eq ""}'>/resources/images/default-profile.png</c:when>
                                                <c:otherwise>/source/${photoDocument.documentFileName}?documentId=${photoDocument.documentId}&source=photo</c:otherwise>
                                            </c:choose>">
                                </div>
                                <div class="col-md-9">
                                    <div class="form-group row">
                                        <label class="col-md-5" for="photo"><spring:message code="update.photo"/></label>
                                        <input type="file" class="form-control-file col-md-7" id="photo" name="photo"
                                               accept="image/*"
                                               data-parsley-max-file-size="1500" data-parsley-trigger="change">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-md-5" for="firstName"><spring:message code="register.name"/></label>
                                        <input name="firstName" type="text" class="form-control col-md-7" id="firstName"
                                               placeholder="<spring:message code="register.placeholder.name" />"
                                               value="${user.firstName}"
                                               data-parsley-trigger="change" required=""
                                               data-parsley-minlength="2" data-parsley-maxlength="15">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-md-5" for="lastName"><spring:message
                                                code="register.lastname"/></label>
                                        <input name="lastName" type="text" class="form-control col-md-7" id="lastName"
                                               placeholder="<spring:message code="register.placeholder.lastname" />"
                                               value="${user.lastName}"
                                               data-parsley-trigger="change" data-parsley-minlength="2"
                                               data-parsley-maxlength="15" required="">
                                    </div>
                                </div>
                            </div>

                            <div class="form-group row">
                                <label class="col-md-5" for="start"><spring:message code="register.birthdate"/></label>
                                <div id="start" class="col-md-7">
                                    <jsp:include page="include/dateinput.jsp"/>
                                </div>
                                <!--<input type="text" class="col-md-7 form-control" id="start" name="birth" value="${user.birthDate}" max="2010-01-01" />
                            -->
                            </div>
                            <div class="form-group row">
                                <label class="col-md-5"><spring:message code="update.gender"/></label>
                                <div class="col-md-7">
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" value="M" id="gender1" autocomplete="off"
                                               <c:if test="${user.gender eq 'M'}">checked</c:if> required="">
                                        <spring:message code="update.male"/>
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" value="F" id="gender2" autocomplete="off"
                                               <c:if test="${user.gender eq 'F'}">checked</c:if>> <spring:message
                                            code="update.female"/>
                                    </label>
                                </div>
                            </div>
                            <div class="form group row">
                                <label class="col-md-5" for="placeofbirth"><spring:message
                                        code="update.birthplace"/></label>
                                <div class="col-md-7" id="placeofbirth">
                                    <div class="form-group row">
                                        <label class="col-md-5" for="country"><spring:message
                                                code="update.country"/></label>
                                        <input name="country" type="text" class="form-control col-md-7" id="country"
                                               value="${user.country}"
                                               data-parsley-trigger="change" required="">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-md-5" for="city"><spring:message code="update.city"/></label>
                                        <input name="city" type="text" class="form-control col-md-7" id="city"
                                               value="${user.city}"
                                               data-parsley-trigger="change" required="">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-md-5" for="phoneNumber"><spring:message code="update.phone"/></label>
                                <input name="phoneNumber" type="text" class="form-control col-md-7" id="phoneNumber"
                                       value="${user.phoneNumber}"
                                       data-parsley-trigger="change" required="">
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <a style="float:right;" href="#" onclick="updateUser();"
                                       class="btn btn-primary"><spring:message code="update.submit"/></a>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="tab-pane fade" id="application" role="tabpanel" aria-labelledby="application-tab">
                        <div id="appForm">
                            <form class="form-horizontal" id="applicationForm" action="${action}" method="post"
                                  enctype="multipart/form-data" data-parsley-validate="true">
                                <div id="stage1">
                                    <div class="form-group">
                                        <label class="col-md-5"><spring:message code="update.request"/>: </label>
                                        <label class="radio-inline">
                                            <input type="radio" name="requestId" value="1" id="requestId1"
                                                   autocomplete="off"
                                                   <c:if test="${user.requestId eq 1}">checked</c:if> required="">
                                            <spring:message code="update.request.application"/>
                                        </label>
                                        <label class="radio-inline">
                                            <input type="radio" name="requestId" value="2" id="requestId2"
                                                   autocomplete="off"
                                                   <c:if test="${user.requestId eq 2}">checked</c:if>> <spring:message
                                                code="update.request.review"/>
                                        </label>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-md-5"><spring:message code="update.application"/>: </label>
                                        <label class="radio-inline">
                                            <input type="radio" name="appType" value="1" id="appType1"
                                                   onclick="handleChange();"
                                                   autocomplete="off"
                                                   <c:if test="${user.appType eq 1}">checked</c:if> required>
                                            Studienkolleg
                                        </label>
                                        <label class="radio-inline">
                                            <input type="radio" name="appType" value="2" id="appType2"
                                                   onclick="handleChange();"
                                                   autocomplete="off"
                                                   <c:if test="${user.appType eq 2}">checked</c:if> required>
                                            <spring:message code="update.application.bachelor"/>
                                        </label>
                                        <label class="radio-inline">
                                            <input type="radio" name="appType" value="3" id="appType3"
                                                   onclick="handleChange();"
                                                   autocomplete="off"
                                                   <c:if test="${user.appType eq 3}">checked</c:if>> <spring:message
                                                code="update.application.master"/>
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-md-5" for="choosecountry">
                                        <spring:message code="form_application.country"/>
                                    </label>
                                    <select id="choosecountry"
                                            class="form-control col-md-7" onchange="countryChange();">
                                        <option selected value="defopiton"><spring:message code="form_application.choosecountry" /></option>
                                        <c:forEach items="${countries}" var="country">
                                            <option value="${country}">${country}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div id="stage2">
                                    <!--<c:forEach items="${labels}" var="label">
                                        <div class="form-group row <c:forEach items='${label.types}' var='type'>${type} </c:forEach>">
                                            <label class="col-md-5" for="${label.name}">${label.name}</label>
                                            <input type="hidden" name="file-headline${labels.indexOf(label)}"
                                                   value="${label.name}">
                                            <input type="file" class="form-control-file col-md-7" name="files"
                                                   id="${label.name}"
                                                   accept="application/pdf, image/*" data-parsley-max-file-size="1500"
                                                   data-parsley-trigger="change">
                                        </div>
                                    </c:forEach>-->
                                </div>
                                <div class="form-group row">
                                    <label class="col-md-5" for="additional">
                                        <spring:message code="update.additional"/>
                                    </label>
                                    <textarea name="additional" id="additional"
                                              class="form-control col-md-7">${application.additional}</textarea>
                                </div>
                            </form>
                            <div class="row">
                                <div class="col-sm-12">
                                    <button style="float:right;" onclick="updateApplication()" class="btn btn-primary">
                                        <spring:message code="update.submit"/>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="include/adsright.jsp" />
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

    function updateUser() {
        hideAlerts();
        var userForm = $('#userForm')[0];
        var data = new FormData(userForm);
        if ($('#userForm').parsley().validate()) {
            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: "/profile/update",
                data: data,
                processData: false,
                contentType: false,
                cache: false,
                timeout: 600000,
                success: function (data) {
                    document.getElementById("alertContainer").innerHTML = (successAlert);
                    document.getElementById("nav-application").click();
                },
                error: function (e) {
                    document.getElementById("alertContainer").innerHTML = (failAlert);
                }
            });

        }


    }

    var type = [];

    function stage2Clear() {
        document.getElementById("stage2").innerHTML = "";
        type = [];
    }

    function countryChange() {
        stage2Clear();
        if(document.getElementById("choosecountry").value === "defoption"){
            return;
        }

        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/profile/getfilelist",
            cache: false,
            data: {"country" : document.getElementById("choosecountry").value},
            success: function (data) {
                document.getElementById("stage2").innerHTML = data;

                const elems = document.getElementsByClassName("applicationfile");
                for (var i = 0; i < elems.length; i++) {
                    type.push(elems[i]);
                }
                handleChange();
            },
            error: function (e) {
                console.log(e);
            }
        });
    }

    function updateApplication() {
        var form = $('#applicationForm')[0];

        var data = new FormData(form);
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/edit",
            data: data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {
                document.getElementById("alertContainer").innerHTML = successAlert;
            },
            error: function (e) {
                document.getElementById("alertContainer").innerHTML = failAlert;
            }
        });
    }

    function handleChange() {
        document.getElementById("stage2").innerHTML = "";
        if (document.getElementById("appType3").checked) {
            for (var i = 0; i < type.length; i++) {
                if(type[i].classList.contains(3)) {
                    document.getElementById("stage2").appendChild(type[i]);
                }
            }
        } else if(document.getElementById("appType2").checked) {
            for (var i = 0; i < type.length; i++) {

                if(type[i].classList.contains(2))
                    document.getElementById("stage2").appendChild(type[i]);
            }
        } else if(document.getElementById("appType1").checked) {
            for (var i = 0; i < type.length; i++) {

                if(type[i].classList.contains(1))
                    document.getElementById("stage2").appendChild(type[i]);
            }
        }
    }

    document.getElementById('photo').onchange = function (evt) {
        var tgt = evt.target || window.event.srcElement,
            files = tgt.files;

        // FileReader support
        if (FileReader && files && files.length) {
            var fr = new FileReader();
            fr.onload = function () {
                document.getElementById("profile-photo").src = fr.result;
            }
            fr.readAsDataURL(files[0]);
        }

        // Not supported
        else {
            // fallback -- perhaps submit the input to an iframe and temporarily store
            // them on the server until the user's session ends.
        }
    }
</script>
<jsp:include page="include/loading.jsp"/>
</body>

</html>