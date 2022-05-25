<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/resources/js/updatealerts.js"></script>
<script>
    function updateUser() {
        hideAlerts();
        var userForm = $('#userForm');
        if(userForm.parsley().validate()) {
            $.ajax({
                type: "POST",
                url: "/dashboard/users/update",
                data: userForm.serialize(),
                success: function (data) {
                    document.getElementById("alertContainer").innerHTML = successAlert;
                },
                error: function (data) {
                    document.getElementById("alertContainer").innerHTML = failAlert;
                }
            });
        }
    }
</script>
<div class="container">
    <div id="alertContainer" style="text-align: center;">

    </div>
</div>
<form id="userForm" class="form-horizontal" action="/dashboard/users/update" method="post" enctype="multipart/form-data" data-parsley-validate="true">
    <input type="hidden" name="userId" value="${user.userId}">
    <input type="hidden" name="requestId" value="${user.requestId}">
    <input type="hidden" name="appType" value="${user.appType}">
    <div class="form-group form-row">
        <label class="col-sm-3" for="email"><spring:message code="login.email"/></label>
        <div class="col-sm-5">
            <input name="email" type="email" class="form-control" id="email"
                   aria-describedby="emailHelp"
                   placeholder="<spring:message code="login.placeholder.email" />"
                   value="${user.email}"
                   data-parsley-trigger="change" required="">
        </div>
    </div>
    <div class="form-group form-row">
        <label class="col-sm-3" for="firstName"><spring:message code="register.name"/></label>
        <div class="col-sm-5">
            <input name="firstName" type="text" class="form-control" id="firstName"
                   placeholder="<spring:message code="register.placeholder.name" />"
                   value="${user.firstName}"
                   data-parsley-trigger="change" required=""
                   data-parsley-minlength="2" data-parsley-maxlength="15">
        </div>
    </div>
    <div class="form-group form-row">
        <label class="col-sm-3" for="lastName"><spring:message
                code="register.lastname"/></label>
        <div class="col-sm-5">
            <input name="lastName" type="text" class="form-control" id="lastName"
                   placeholder="<spring:message code="register.placeholder.lastname" />"
                   value="${user.lastName}"
                   data-parsley-trigger="change" data-parsley-minlength="2"
                   data-parsley-maxlength="15" required="">
        </div>
    </div>
    <c:choose>
        <c:when test="${sessionScope.get('role') eq 1}">
            <div class="form-group form-row">
                <label class="col-sm-3" for="role"><spring:message code="update.role"/></label>
                <div class="col-sm-5">
                    <select id="role" name="roleId" class="form-control">
                        <c:forEach var="roleVar" items="${roleList}">
                            <option value="${roleVar.roleId}"<c:if
                                    test="${user.roleId eq roleVar.roleId}">
                                selected="selected"
                            </c:if>>${roleVar.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <input type="hidden" name="roleId" value="${user.roleId}">
        </c:otherwise>
    </c:choose>
    <div class="form-group form-row">
        <label class="col-sm-3" for="agency"><spring:message code="update.agency"/></label>
        <div class="col-sm-5">
            <select id="agency" name="agencyId" class="form-control">
                <c:forEach var="agencyVar" items="${agencies}">
                    <option value="${agencyVar.agencyId}"<c:if
                            test="${user.agencyId eq agencyVar.agencyId}">
                        selected="selected"
                    </c:if>>${agencyVar.agencyName}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="form-group col-sm-8">
        <a href="#" onclick="updateUser();" class="btn btn-primary" style="margin-left: 5px; float:right"><spring:message
                code="update.submit"/></a>
        <a href="/dashboard/users" class="btn btn-danger" style="float:right"><spring:message
                code="update.cancel"/></a>
    </div>
</form>