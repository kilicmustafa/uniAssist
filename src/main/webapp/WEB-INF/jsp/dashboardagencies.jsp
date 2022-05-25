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


    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="/resources/css/demo.css" rel="stylesheet" />


    <!--     Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300' rel='stylesheet' type='text/css'>
    <link href="/resources/css/pe-icon-7-stroke.css" rel="stylesheet" />

    <script>
        function deleteAgency(id) {
            $.ajax({
                type: "POST",
                url: "deleteAgency",
                data: {agencyId:id},
                success: function(){
                    document.getElementById(id).remove();
                }
            });
        }
    </script>

    <style>
        .modal-backdrop {
            z-index: -1;
            background: white;
        }
    </style>
</head>
<body>

<div class="wrapper">
    <jsp:include page="include/dashboardsidebar.jsp"></jsp:include>

    <div class="main-panel">
        <jsp:include page="include/dashboardnavbar.jsp"></jsp:include>


        <div class="content">
            <div class="container-fluid">

                <div class="row">
                    <p class="lead"><spring:message code="dashboard.agencies" /></p>
                    <table class="table">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col"><spring:message code="dashboard.agency"/></th>
                            <th scope="col"><spring:message code="dashboard.agency.short"/></th>
                            <th scope="col"><spring:message code="dashboard.agency.email"/></th>
                            <th scope="col"><spring:message code="dashboard.agency.address"/></th>
                            <th scope="col"><spring:message code="dashboard.agency.phone"/></th>
                            <c:if test="${sessionScope.get('role') eq 1}">
                            <th scope="col"><spring:message code="operations"/></th>
                            </c:if>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="agency" items="${agencies}">
                            <tr id="${agency.agencyId}">
                                <th scope="row">${agency.agencyId}</th>
                                <td>${agency.agencyName}</td>
                                <td>${agency.agencyShortName}</td>
                                <td>${agency.agencyEmail}</td>
                                <td>${agency.agencyAddress}</td>
                                <td>${agency.agencyPhone}</td>
                                <c:if test="${sessionScope.get('role') eq 1}">
                                <td>
                                    <a href="/dashboard/agencies/users/${agency.agencyId}"
                                       data-toggle="tooltip" data-placement="top" title="<spring:message code='agencies.viewusers' />">
                                        <i class="fa fa-search"></i>
                                    </a>
                                    <a href="/dashboard/agencies/settings/${agency.agencyId}"
                                       data-toggle="tooltip" data-placement="top" title="<spring:message code='agencies.settings' />">
                                        <i class="fa fa-cog"></i>
                                    </a>
                                    <span data-toggle="modal" data-target="#modal${agency.agencyId}">
                                        <a href="#" class="dropdown-toggle" aria-expanded="true"
                                           data-toggle="tooltip" data-placement="top" title="<spring:message code='agencies.delete' />">
                                        <i class="fa fa-times"></i>
                                        </a>
                                    </span>
                                </td>
                                </c:if>
                            </tr>

                            <!-- Modal -->
                            <div class="modal fade" id="modal${agency.agencyId}" tabindex="-1" role="dialog" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="exampleModalLabel"><spring:message code='userlist.deleteheadline' /></h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                                ${agency.agencyName} <spring:message code="agencyies.deleteverifymessage"/>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal"><spring:message code="update.cancel"/></button>
                                            <button type="button" data-dismiss="modal"
                                                    onclick="deleteAgency(${agency.agencyId});" class="btn btn-primary"><spring:message code="agencies.delete"/></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
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
<script>
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
    });
</script>
</body>

</html>
