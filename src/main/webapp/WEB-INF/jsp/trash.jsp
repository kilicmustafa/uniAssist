<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        table a {
            color: #1b6d85;
        }

        .btn {
            font-size: 12px;
        }

        #buttonContainer a {
            float: right;
        }

        .modal-backdrop {
            z-index: -1;
            background: white;
        }

    </style>

    <script>
        var alert = " <div class=\"row\">\n" +
            "                        <div id=\"successAlert\" class=\"alert alert-success col-md-12\" role=\"alert\">\n" +
            "                            <spring:message code='userlist.restored'/>\n" +
            "                        </div>\n" +
            "                    </div>";

        function deleteUser(id) {
            $.ajax({
                type: "POST",
                url: "deleteFromTrash",
                data: {userId: id},
                success: function () {
                    document.getElementById(id).remove();
                }
            });
        }

        function restore(id) {
            document.getElementById("alertContainer").innerHTML = "";
            $.ajax({
                type: "POST",
                url: "restore",
                data: {userId: id},
                success: function () {
                    document.getElementById(id).remove();
                    document.getElementById("alertContainer").innerHTML = alert;
                }
            });
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
                <div id="alertContainer" style="text-align: center;">

                </div>
                <div class="row">
                    <div class="col-md-3">
                        <p class="lead"><spring:message code="usermanagement"/></p>
                    </div>
                    <!--<div class="col-md-9" id="buttonContainer">
                        <c:if test="${sessionScope.get('role') eq 1}">
                            <a href="/dashboard/users?filter=authorizedusers" class="btn btn-warning">Yetkili Kullanıcılar</a>
                        </c:if>
                        <a href="/dashboard/users?filter=passive" class="btn btn-info">Pasif Kullanıcılar</a>
                        <a href="/dashboard/users?filter=active" class="btn btn-primary">Aktif Kullanıcılar</a>
                        <a href="/dashboard/users?filter=completed" class="btn btn-danger">Tamamlanmış Başvurular</a>
                        <a href="/dashboard/users" class="btn btn-success">Tüm Kullanıcılar</a>
                    </div>-->
                </div>
                <table class="table">
                    <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col"><spring:message code="dashboard.names"/></th>
                        <th scope="col"><spring:message code="dashboard.lastnames"/></th>
                        <th scope="col">Email</th>
                        <th scope="col"><spring:message code="dashboard.appstate"/></th>
                        <c:if test="${sessionScope.get('role') eq 1}">
                            <th scope="col"><spring:message code="login.password"/></th>
                        </c:if>
                        <th scope="col"><spring:message code="userlist.agency"/></th>
                        <th scope="col"><spring:message code="dashboard.registrationdate"/></th>
                        <th scope="col"><spring:message code="operations"/></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr id="${user.userId}">
                            <th scope="row">${user.userId}</th>
                            <td>${user.firstName}</td>
                            <td>${user.lastName}</td>
                            <td>${user.email}</td>
                            <td>
                                <c:forEach begin="1" end="${applicationStates.get(user.userId)}" varStatus="loop">
                                    &#11044;
                                </c:forEach>
                            </td>
                            <c:if test="${sessionScope.get('role') eq 1}">
                                <td>${user.password}</td>
                            </c:if>
                            <td>${agencyMap.get(user.agencyId)}</td>
                            <td><fmt:formatDate value="${user.registrationDate}" pattern="dd.MM.YYYY"/></td>
                            <td>
                                <a href="#" onclick="restore(${user.userId});" class="dropdown-toggle"
                                   aria-expanded="true"
                                   data-toggle="tooltip" data-placement="top"
                                   title="<spring:message code='userlist.restore' />">
                                    <i class="fa fa-undo"></i>
                                </a>
                                <span data-toggle="modal" data-target="#modal${user.userId}">
                                    <a href="#" class="dropdown-toggle" aria-expanded="true"
                                       data-toggle="tooltip" data-placement="top"
                                       title="<spring:message code='userlist.delete' />">
                                    <i class="fa fa-times"></i>
                                </a>
                                </span>
                            </td>
                        </tr>
                        <!-- Modal -->
                        <div class="modal fade" id="modal${user.userId}" tabindex="-1" role="dialog" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel"><spring:message
                                                code='userlist.deleteheadline'/></h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                            ${user.firstName} ${user.lastName} <spring:message
                                            code="userlist.deleteverifymessage"/>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">
                                            <spring:message code="update.cancel"/></button>
                                        <button type="button" data-dismiss="modal"
                                                onclick="deleteUser(${user.userId});" class="btn btn-primary">
                                            <spring:message code="userlist.delete"/></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>


        <jsp:include page="include/dashboardfooter.jsp"/>

    </div>
</div>

<!--   Core JS Files   -->
<script src="/resources/js/jquery.3.2.1.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
        integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
<script src="/resources/js/bootstrap.min.js" type="text/javascript"></script>

<!--  Charts Plugin -->
<script src="/resources/js/chartist.min.js"></script>

<!--  Notifications Plugin    -->
<script src="/resources/js/bootstrap-notify.js"></script>

<!-- Light Bootstrap Table Core javascript and methods for Demo purpose -->
<script src="/resources/js/light-bootstrap-dashboard.js?v=1.4.0"></script>

<script>
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
    });
</script>
</body>
</html>
