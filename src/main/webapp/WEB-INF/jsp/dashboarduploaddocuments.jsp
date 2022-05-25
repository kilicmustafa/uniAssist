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
<html lang="tr">
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


    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="/resources/css/demo.css" rel="stylesheet" />


    <!--     Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300' rel='stylesheet' type='text/css'>
    <link href="/resources/css/pe-icon-7-stroke.css" rel="stylesheet" />
    <script>
        var counter = 1;
        var innerHtml;

        window.onload = function() {
          innerHtml = document.getElementById("row1").innerHTML.toString();
        };

        function appendElement() {
            counter++;
            var domElement = document.createElement("tr");
            domElement.id = "row" + counter;
            innerHtml = innerHtml.replace("file-headline1", "file-headline" + counter);
            domElement.innerHTML = innerHtml.trim();

            document.getElementById("tableContainer").appendChild(domElement);
            innerHtml = document.getElementById("row1").innerHTML.toString();
        }

        function removeElement() {
            if(counter > 0) {
                document.getElementById("row"+counter).remove();
                counter--;
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
                <p class="lead">${user.firstName} ${user.lastName} <spring:message code="dashboard.addcoumentforuser" /></p>
                <form action="/dashboard/documents/save" method="post" enctype="multipart/form-data">
                    <table class="table">
                        <thead>
                        <tr>
                            <th scope="col"><spring:message code="dashboard.fileheadline" /></th>
                            <th scope="col"><spring:message code="dashboard.file" /></th>
                        </tr>
                        </thead>
                        <tbody id="tableContainer">
                        <tr id="row1">
                            <td><input type="text" class="form-control" name="file-headline1"></td>
                            <td><input type="file" class="form-control-file" id="files" name="files" accept="application/pdf, image/*"></td>
                        </tr>
                        </tbody>
                    </table>
                    <input type="hidden" name="userId" value="${userId}">
                    <div id="buttonContainer" class="row" style="float:right;">
                        <a onclick="removeElement();" href="#" class="btn btn-primary"><spring:message code="removefile" /></a>
                        <a onclick="appendElement();" href="#" class="btn btn-primary"><spring:message code="addfile" /></a>
                        <button type="submit" class="btn btn-primary"><spring:message code="update.submit" /></button>
                    </div>
                </form>
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

<!-- Light Bootstrap Table DEMO methods, don't include it in your project! -->
<script src="/resources/js/demo.js"></script>

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
