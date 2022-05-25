<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>

    function updateApplicationState() {
        hideAlerts()
        $.ajax({
            type: "POST",
            url: "/dashboard/applicationstates/update",
            data: $('#applicationStateForm').serialize(),
            success: function (data) {
                document.getElementById("alertContainer").innerHTML = successAlert;
            },
            error: function (data) {
                document.getElementById("alertContainer").innerHTML = failAlert;
            }
        });
    }
</script>
<form id="applicationStateForm" action="/dashboard/application/update">
    <input type="hidden" name="userId" value="${user.userId}">
    <input type="hidden" name="applicationId" value="${application.applicationId}">
    <div class="form-group row">
        <label class="col-md-3" for="applicationStates"><spring:message code="update.appstate"/></label>
        <div class="col-md-5">
            <select id="applicationStates" name="appStateId" class="form-control">
                <c:forEach var="applicationState" items="${applicationStates}">
                    <option value="${applicationState.applicationStateID}"<c:if
                            test="${appStateId eq applicationState.applicationStateID}">
                        selected="selected"
                    </c:if>>${applicationState.name}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-md-3" for="forUser"><spring:message code="update.note"/></label>
        <div class="col-md-5">
            <textarea class="form-control" id="forUser" name="forUser"
                      rows="3">${note.forUser}</textarea>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-md-3" for="sendNoteMail"><spring:message code="update.sendnotemail"/></label>
        <div class="col-md-5">
            <input type="checkbox" id="sendNoteMail" name="sendNoteEmail" checked />
        </div>
    </div>
    <div class="form-group row">
        <label class="col-md-3" for="specialNote"><spring:message code="update.special.note"/></label>
        <div class="col-md-5">
            <textarea class="form-control" id="specialNote" name="forUs"
                      rows="3">${note.forUs}</textarea>
        </div>
    </div>
    <div class="col-md-8">
        <a href="#" onclick="updateApplicationState();" class="btn btn-primary" style="margin-left:5px; float:right"><spring:message
                code="update.submit"/></a>
        <a href="/dashboard/users" class="btn btn-danger" style="float:right"><spring:message
                code="update.cancel"/></a>
    </div>
</form>