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
        function deleteFormat(c, n) {
            $.ajax({
                type: "POST",
                url: "/dashboard/formats/delete",
                data: {country:c, name:n},
                success: function(){
                    document.getElementById(c+n).remove();
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
                <c:forEach items="${formats}" var="format">
                    <div class="row">
                        <p class="lead">${format.key}</p>
                        <table class="table">
                            <thead>
                            <tr>
                                <th scope="col"><spring:message code="format.filename" /></th>
                                <th scope="col"><spring:message code="format.apptypes" /></th>
                                <c:if test="${sessionScope.get('role') eq 1}">
                                    <th scope="col"><spring:message code="operations" /></th>
                                </c:if>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="applicationFormat" items="${format.value}">
                                <tr id="${format.key}${applicationFormat.name}">
                                    <td>${applicationFormat.name}</td>
                                    <td><c:forEach var="type" items="${applicationFormat.types}">
                                        <p style="font-size: 12px;"><c:choose>
                                            <c:when test="${type eq 1}">Studienkolleg</c:when>
                                            <c:when test="${type eq 2}"><spring:message code="bachelor" /></c:when>
                                            <c:when test="${type eq 3}"><spring:message code="master" /></c:when>
                                        </c:choose></p>
                                    </c:forEach></td>
                                    <c:if test="${sessionScope.get('role') eq 1}">
                                        <td>
                                            <a href="/dashboard/formats/update/${applicationFormat.applicationFormatId}" data-toggle="tooltip" data-placement="top" title="<spring:message code='format.edit' />">
                                                <i class="fa fa-pencil"></i>
                                            </a>
                                            <span data-toggle="modal" data-target="#modal${applicationFormat.applicationFormatId}">
                                                <a href="#" class="dropdown-toggle" aria-expanded="true"
                                                   data-toggle="tooltip" data-placement="top" title="<spring:message code='userlist.delete' />">
                                                <i class="fa fa-times"></i>
                                                </a>
                                             </span>
                                        </td>
                                    </c:if>
                                </tr>

                                <!-- Modal -->
                                <div class="modal fade" id="modal${applicationFormat.applicationFormatId}" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalLabel"><spring:message code='userlist.deleteheadline' /></h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                    ${applicationFormat.name} <spring:message code="applicationformat.deleteverifymessage"/>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal"><spring:message code="update.cancel"/></button>
                                                <button type="button" data-dismiss="modal"
                                                        onclick="deleteFormat('${format.key}', '${applicationFormat.name}');" class="btn btn-primary"><spring:message code="agencies.delete"/></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:forEach>
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

<!-- Light Bootstrap Table Core javascript and methods for Demo purpose -->
<script src="/resources/js/light-bootstrap-dashboard.js?v=1.4.0"></script>
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
