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
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

    <title>Uni-Assist - Dashboard</title>

    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />


    <!-- Bootstrap core CSS     -->
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Animation library for notifications   -->
    <link href="/resources/css/animate.min.css" rel="stylesheet"/>

    <!--  Light Bootstrap Table core CSS    -->
    <link href="/resources/css/light-bootstrap-dashboard.css?v=1.4.0" rel="stylesheet"/>


    <!--     Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300' rel='stylesheet' type='text/css'>
    <link href="/resources/css/pe-icon-7-stroke.css" rel="stylesheet" />

    <style>
        table a {
            color: #1b6d85;
        }

        .btn {
            font-size: 12px;
        }

        #buttonContainer a {
            float:right;
        }

        .modal-backdrop {
            z-index: -1;
            background: white;
        }

    </style>

    <script>
        function deleteUser(id) {
            $.ajax({
                type: "POST",
                url: "deleteUser",
                data: {userId:id},
                success: function(){
                    document.getElementById(id).remove();
                }
            });
        }

        function moveToTrash(id) {
            $.ajax({
                type: "POST",
                url: "moveToTrash",
                data: {userId:id},
                success: function(){
                    document.getElementById(id).remove();
                    alert("Kullanıcı çöp kutusuna taşındı.");
                }
            });
        }

        function viewProfile(id) {
            var win = window.open("/viewProfile/"+id, '_blank');
            win.focus();
        }

        function adddocuments(id) {
            var win = window.open("/dashboard/documents/"+id, '_blank');
            win.focus();
        }

        function makeApplication(id) {
            var win = window.open("/dashboard/application/"+id, '_blank');
            win.focus();
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
                <h4 class="lead"><spring:message code="usernotfound" /></h4>
            </div>
        </div>


        <jsp:include page="include/dashboardfooter.jsp" />

    </div>
</div>

<!--   Core JS Files   -->
<script src="/resources/js/jquery.3.2.1.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
<script src="/resources/js/bootstrap.min.js" type="text/javascript"></script>

<!--  Charts Plugin -->
<script src="/resources/js/chartist.min.js"></script>

<!--  Notifications Plugin    -->
<script src="/resources/js/bootstrap-notify.js"></script>

<!--  Google Maps Plugin    -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>

<!-- Light Bootstrap Table Core javascript and methods for Demo purpose -->
<script src="/resources/js/light-bootstrap-dashboard.js?v=1.4.0"></script>

<script>
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
    });
</script>
</body>
</html>
