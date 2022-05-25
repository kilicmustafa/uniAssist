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

    <link rel="stylesheet" href="/resources/css/parsley.css">

    <!--     Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300' rel='stylesheet' type='text/css'>
    <link href="/resources/css/pe-icon-7-stroke.css" rel="stylesheet"/>
</head>
<body>

<div class="wrapper">
    <jsp:include page="include/dashboardsidebar.jsp"></jsp:include>

    <div class="main-panel">
        <jsp:include page="include/dashboardnavbar.jsp"></jsp:include>

        <div class="content">
            <div class="container-fluid">
                <p class="lead"><spring:message code="update.apply.format" /></p>
                <c:if test="${param.added eq 'true'}">
                    <div class="alert alert-success" role="alert">
                        <spring:message code="formatupdated"/>
                    </div>
                </c:if>
                <form action="/dashboard/formats/update" method="post" data-parsley-validate="">
                    <input type="hidden" name="formatId" id="formatId" value="${formatId}">
                    <table class="table">
                        <thead>
                        <tr>
                            <th scope="col"><spring:message code="update.country" /></th>
                            <th scope="col"><spring:message code="format.requestedfilename" /></th>
                            <th>#</th>
                        </tr>
                        </thead>
                        <tbody id="tableContainer">
                        <tr id="row1">
                            <td><input type="text" class="form-control" name="country"
                                       value="${applicationFormat.country}" data-parsley-trigger="change" required="">
                            </td>
                            <td><input type="text" class="form-control" name="name" value="${applicationFormat.name}"
                                       data-parsley-trigger="change" required=""/></td>
                            <td>
                                <c:set var="studienkolleg" value="false" />
                                <c:set var="bachelor" value="false" />
                                <c:set var="master" value="false" />
                                <c:forEach var="type" items="${applicationFormat.types}">
                                    <c:choose>
                                        <c:when test="${type eq 1}">
                                            <c:set var="studienkolleg" value="true" />
                                        </c:when>
                                        <c:when test="${type eq 2}">
                                            <c:set var="bachelor" value="true" />
                                        </c:when>
                                        <c:when test="${type eq 3}">
                                            <c:set var="master" value="true" />
                                        </c:when>
                                    </c:choose>
                                </c:forEach>
                                <div class="form-check">
                                    <input type="checkbox" class="form-check-input" id="studienkolleg"
                                           name="studienkolleg"
                                    <c:if test='${studienkolleg eq true}'>
                                        checked
                                    </c:if>>
                                    <label class="form-check-label" for="studienkolleg">Studienkolleg</label>
                                </div>
                                <div class="form-check">
                                    <input type="checkbox" class="form-check-input" id="bachelor" name="bachelor"
                                           <c:if test="${bachelor eq true}">checked="checked"</c:if>/>
                                    <label class="form-check-label" for="bachelor"><spring:message code="bachelor" /></label>
                                </div>
                                <div class="form-check">
                                    <input type="checkbox" class="form-check-input" id="master" name="master"
                                    <c:if test='${master eq true}'>
                                           checked
                                    </c:if>>
                                    <label class="form-check-label" for="master"><spring:message code="master" /></label>
                                </div>
                            </td>
                        </tr>
                        <tr id="row2">
                            <td><label>German</label></td>
                            <td><input type="text" class="form-control" name="de" value="${translations.get('de')}"></td>
                        </tr>
                        <tr id="row3">
                            <td><label>English</label></td>
                            <td><input type="text" class="form-control" name="en" value="${translations.get('en')}"></td>
                        </tr>
                        <tr id="row4">
                            <td><label>Turkish</label></td>
                            <td><input type="text" class="form-control" name="tr" value="${translations.get('tr')}"></td>
                        </tr>
                        <tr id="row5">
                            <td><label>Chinese</label></td>
                            <td><input type="text" class="form-control" name="cn" value="${translations.get('cn')}"></td>
                        </tr>
                        </tbody>
                    </table>
                    <div id="buttonContainer" class="row" style="float:right;">
                        <button type="submit" class="btn btn-primary"><spring:message code="update.submit" /></button>
                    </div>
                </form>
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
