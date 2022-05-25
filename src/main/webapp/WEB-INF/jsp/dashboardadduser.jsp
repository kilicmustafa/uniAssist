<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: cemasma
  Date: 6/21/2018
  Time: 4:11 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

    <title>Uni-Assist - Dashboard</title>

    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport'/>
    <meta name="viewport" content="width=device-width"/>


    <!-- Bootstrap core CSS     -->
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet"/>

    <!-- Animation library for notifications   -->
    <link href="/resources/css/animate.min.css" rel="stylesheet"/>

    <!--  Light Bootstrap Table core CSS    -->
    <link href="/resources/css/light-bootstrap-dashboard.css?v=1.4.0" rel="stylesheet"/>


    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="/resources/css/demo.css" rel="stylesheet"/>


    <!--     Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300' rel='stylesheet' type='text/css'>
    <link href="/resources/css/pe-icon-7-stroke.css" rel="stylesheet"/>
    <script src="/resources/js/script.js"></script>
    <script>
        var stage;
        window.onload = function() {
            document.getElementById("day").className = "col-sm-4";
            document.getElementById("month").className = "col-sm-4";
            document.getElementById("year").className = "col-sm-4";

            stage = document.getElementById("stage3");
            if(document.getElementById("appType1").checked) {
                document.getElementById("stage3").remove();
            }
        };

        function handleChange() {
            if(document.getElementById("appType2").checked) {
                console.log(stage);
                document.getElementById("registerForm").appendChild(stage);
                stage.style.visibility = "visible";
            } else {
                stage.style.visibility = "hidden";
                document.getElementById("stage3").remove();
            }
        }
    </script>
</head>
<body>

<div class="wrapper">
    <jsp:include page="include/dashboardsidebar.jsp"></jsp:include>

    <div class="main-panel">
        <jsp:include page="include/dashboardnavbar.jsp"></jsp:include>


        <div class="content">
            <div class="container-fluid">
                <c:if test="${param.fail eq 'mail'}">
                    <div style="text-align: center;">
                        <h3 class="h3">Email hesabı zaten kayıtlı.</h3>
                    </div>
                </c:if>
                <form class="form-horizontal" id="registerForm" action="/dashboard/adduser" method="post"
                      enctype="multipart/form-data" data-parsley-validate="">
                    <div class="form-group form-row">
                        <label class="col-sm-2 col-form-label" for="email"><spring:message code="login.email" /></label>
                        <div class="col-sm-6">
                            <input name="email" type="email" class="form-control" id="email" aria-describedby="emailHelp"
                                   placeholder="<spring:message code="login.placeholder.email" />" data-parsley-trigger="change" required=""/>
                        </div>
                    </div>
                    <div class="form-group form-row">
                        <label for="firstName" class="col-sm-2 col-form-label"><spring:message code="register.name" /></label>
                        <div class="col-sm-6"><input name="firstName" value="${user.firstName}" type="text"
                                                      class="form-control" id="firstName" placeholder="Enter Name"  data-parsley-minlength="2" data-parsley-maxlength="15" required=""/>
                        </div>
                    </div>
                    <div class="form-group form-row">
                        <label for="lastName" class="col-sm-2 col-form-label"><spring:message code="register.lastname" /></label>
                        <div class="col-sm-6"><input name="lastName" type="text" value="${user.lastName}"
                                                      class="form-control" id="lastName"
                                                      placeholder="Enter Surname"  data-parsley-minlength="2" data-parsley-maxlength="15" required=""/>
                        </div>
                    </div>

                    <div class="form-group form-row">
                        <label for="inputPassword" class="col-sm-2 col-form-label"><spring:message code="login.password" /></label>
                        <div class="col-sm-6"><input name="password" type="password" class="form-control"
                                                      id="inputPassword" placeholder="Password"
                                                      data-toggle="tooltip" data-placement="top" title=""
                                                      data-original-title="Şifrenizi giriniz." data-parsley-trigger="change" data-parsley-minlength="8" data-parsley-maxlength="12" required=""/>
                        </div>
                    </div>
                    <div class="form-group form-row">
                        <label for="passwordAgain" class="col-sm-2 col-form-label"><spring:message code="register.password.again" /></label>
                        <div class="col-sm-6"><input name="passwordAgain" type="password" class="form-control"
                                                      id="passwordAgain" placeholder="Password"
                                                      data-toggle="tooltip" data-placement="top" title=""
                                                      data-original-title="Şifrenizi tekrar giriniz." data-parsley-equalto="#inputPassword"
                                                      data-parsley-trigger="change" data-parsley-minlength="2" data-parsley-maxlength="12" required="">
                        </div>
                    </div>
                    <div class="form-group form-row">
                        <label for="agencyId" class="col-sm-2 col-form-label"><spring:message code="dashboard.adduser.chooseagency" /></label>
                        <div class="col-sm-6">
                            <select class="form-control" id="agencyId" name="agencyId">
                                <c:forEach var="agency" items="${agencies}">
                                    <option value="${agency.agencyId}" <c:if test="${authorizedAgencyId eq agency.agencyId}">selected</c:if>>${agency.agencyName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label" for="start"><spring:message code="register.birthdate" /></label>
                        <div id="start" class="col-sm-6">
                            <jsp:include page="include/dateinput.jsp" />
                        </div>
                        <!--<input type="text" class="col-md-7 form-control" id="start" name="birth" value="${user.birthDate}" max="2010-01-01" />
                            -->
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label"><spring:message code="update.gender" /></label>
                        <div class="col-sm-6">
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="M" id="gender1" autocomplete="off"
                                       required=""> <spring:message code="update.male" />
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="F" id="gender2" autocomplete="off"> <spring:message code="update.female" />
                            </label>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label" for="placeofbirth"><spring:message code="update.birthplace" /></label>
                        <div class="col-sm-6" id="placeofbirth">
                            <div class="">
                                <label class="col-md-5" for="country"><spring:message code="update.country" /></label>
                                <input name="country" type="text" class="form-control col-md-7" id="country" placeholder="<spring:message code='update.entercountry' />"
                                       data-parsley-trigger="change" required="">
                            </div>
                            <div class="">
                                <label class="col-md-5" for="city"><spring:message code="update.city" /></label>
                                <input name="city" type="text" class="form-control col-md-7" id="city" placeholder="<spring:message code='update.entercity' />"
                                       data-parsley-trigger="change" required="">
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label" for="phoneNumber"><spring:message code="update.phone" /></label>
                        <div class="col-sm-6">
                            <input name="phoneNumber" type="text" class="form-control" id="phoneNumber" placeholder="<spring:message code='update.enterphone' />"
                                   data-parsley-trigger="change" required="">
                        </div>
                    </div>
                </form>
                <div class="row">
                    <!--<div class="col-sm-6">
                        <button id="preStage" onclick="changeStage(-1)" class="btn btn-primary disabled">Önceki</button>
                    </div>-->
                    <div class="col-sm-8">
                        <button id="nextStage" style="float:right;" onclick="sendRegisterForm()" class="btn btn-primary">
                            <spring:message code="register.button" />
                        </button>
                    </div>
                </div>
            </div>
        </div>


        <jsp:include page="include/dashboardfooter.jsp" />

    </div>
</div>


</body>

<!--   Core JS Files   -->
<script src="/resources/js/jquery.3.2.1.min.js" type="text/javascript"></script>
<script src="/resources/js/bootstrap.min.js" type="text/javascript"></script>

<!--  Charts Plugin -->
<script src="/resources/js/chartist.min.js"></script>

<!--  Notifications Plugin    -->
<script src="/resources/js/bootstrap-notify.js"></script>

<!--  Google Maps Plugin    -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>

<!-- Light Bootstrap Table Core javascript and methods for Demo purpose -->
<script src="/resources/js/light-bootstrap-dashboard.js?v=1.4.0"></script>
<link rel="stylesheet" href="/resources/css/parsley.css">
<script src="http://parsleyjs.org/dist/parsley.min.js"></script>
<!--
<script type="text/javascript">
    $(document).ready(function(){

        demo.initChartist();

        $.notify({
            icon: 'pe-7s-gift',
            message: "Welcome to <b>Light Bootstrap Dashboard</b> - a beautiful freebie for every web developer."

        },{
            type: 'info',
            timer: 4000
        });

    });
</script>
-->

</html>
