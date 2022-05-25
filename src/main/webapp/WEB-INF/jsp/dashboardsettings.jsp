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

    <!--     Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300' rel='stylesheet' type='text/css'>
    <link href="/resources/css/pe-icon-7-stroke.css" rel="stylesheet"/>

    <style>
        a {
            color: #1b6d85;
        }
    </style>

    <script>
        var successAlert = "<div class=\"row\">\n" +
            "            <div id=\"successAlert\" class=\"alert alert-success col-md-12\" role=\"alert\">\n" +
            "                <spring:message code='update.success'/>\n" +
            "            </div>\n" +
            "        </div>";
        var failAlert = "<div class=\"row\">\n" +
            "            <div id=\"failAlert\" class=\"alert alert-danger col-md-12\" role=\"alert\">\n" +
            "                <spring:message code='update.failed'/>\n" +
            "            </div>\n" +
            "        </div>";

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

        var userForm, applicationStateForm, applicationForm, passwordForm;

        function passwordSettings() {
            if (document.getElementById("appForm") !== null) {
                document.getElementById("appForm").remove();
            }

            if (document.getElementById("applicationStateForm") !== null) {
                document.getElementById("applicationStateForm").remove();
            }

            if (document.getElementById("userForm") !== null) {
                document.getElementById("userForm").remove();
            }

            if (document.getElementById("passwordForm") === null) {
                document.getElementById("password").appendChild(passwordForm);
            }
        }

        function userSettings() {
            if (document.getElementById("applicationForm") !== null) {
                document.getElementById("applicationForm").remove();
            }

            if (document.getElementById("applicationStateForm") !== null) {
                document.getElementById("applicationStateForm").remove();
            }

            if (document.getElementById("passwordForm") !== null) {
                document.getElementById("passwordForm").remove();
            }

            if (document.getElementById("userForm") === null) {
                document.getElementById("user").appendChild(userForm);
            }
        }

        function applicationSettings() {
            if (document.getElementById("userForm") !== null) {
                document.getElementById("userForm").remove();
            }

            if (document.getElementById("applicationForm") !== null) {
                document.getElementById("applicationForm").remove();
            }

            if (document.getElementById("passwordForm") !== null) {
                document.getElementById("passwordForm").remove();
            }

            if (document.getElementById("applicationStateForm") === null) {
                document.getElementById("appState").appendChild(applicationStateForm);
            }
        }

        function fileSettings() {
            if (document.getElementById("userForm") !== null) {
                document.getElementById("userForm").remove();
            }

            if (document.getElementById("passwordForm") !== null) {
                document.getElementById("passwordForm").remove();
            }

            if (document.getElementById("applicationStateForm") !== null) {
                document.getElementById("applicationStateForm").remove();
            }

            if (document.getElementById("applicationForm") === null) {
                document.getElementById("application").appendChild(applicationForm);
            }
        }

        window.onload = function () {
            userForm = document.getElementById("userForm");
            applicationForm = document.getElementById("applicationForm");
            applicationStateForm = document.getElementById("applicationStateForm");
            passwordForm = document.getElementById("passwordForm");

            stage = document.getElementById("stage3");
            if (document.getElementById("appType1").checked) {
                document.getElementById("stage3").remove();
            }

            if (document.getElementById("applicationForm") !== null) {
                document.getElementById("applicationForm").remove();
            }

            if (document.getElementById("applicationStateForm") !== null) {
                document.getElementById("applicationStateForm").remove();
            }

            if (document.getElementById("passwordForm") !== null) {
                document.getElementById("passwordForm").remove();
            }
        };
    </script>
</head>
<body>

<div class="wrapper">
    <jsp:include page="include/dashboardsidebar.jsp"></jsp:include>

    <div class="main-panel">
        <jsp:include page="include/dashboardnavbar.jsp"></jsp:include>

        <div class="content">
            <div class="container-fluid">
                <div class="container">
                    <div id="alertContainer" style="text-align: center;">

                    </div>
                </div>
                <ul class="nav nav-tabs" id="myTab" role="tablist" style="margin-bottom: 25px;">
                    <li class="nav-item">
                        <a onclick="userSettings();" class="nav-link active" id="nav-user" data-toggle="tab"
                           href="#user" role="tab" aria-controls="user" aria-selected="true"><spring:message code="userlist.usersettings" /></a>
                    </li>
                    <li class="nav-item">
                        <a onclick="applicationSettings();" class="nav-link" id="nav-appState" data-toggle="tab"
                           href="#appState" role="tab" aria-controls="appState" aria-selected="false"><spring:message code="dashboard.appstate" /></a>
                    </li>
                    <li class="nav-item">
                        <a onclick="fileSettings();" class="nav-link" id="nav-application" data-toggle="tab"
                           href="#application" role="tab" aria-controls="application" aria-selected="false"><spring:message code="update.appsettings" /></a>
                    </li>
                    <li class="nav-item">
                        <a onclick="passwordSettings();" class="nav-link" id="nav-password" data-toggle="tab"
                           href="#password" role="tab" aria-controls="password" aria-selected="false"><spring:message code="update.passwordsettings" /></a>
                    </li>
                </ul>
                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active in" id="user" role="tabpanel" aria-labelledby="user-tab">
                        <jsp:include page="include/form_user.jsp" />
                    </div>
                    <div class="tab-pane fade" id="appState" role="tabpanel" aria-labelledby="appState-tab">
                        <jsp:include page="include/form_appstate.jsp" />
                    </div>
                    <div class="tab-pane fade" id="application" role="tabpanel" aria-labelledby="application-tab">
                        <jsp:include page="include/form_application.jsp"/>
                    </div>
                    <div class="tab-pane fade" id="password" role="tabpanel" aria-labelledby="password-tab">
                        <jsp:include page="include/form_password.jsp"/>
                    </div>
                </div>
            </div>
        </div>


        <jsp:include page="include/dashboardfooter.jsp"/>

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
