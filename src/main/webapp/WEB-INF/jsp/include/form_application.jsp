
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script>
    var type = [];

    function stage2Clear() {
        document.getElementById("stage2").innerHTML = "";
        type = [];
    }

    function countryChange() {
        stage2Clear();
        if(document.getElementById("choosecountry").value === "defoption"){
            return;
        }

        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/profile/getfilelist",
            cache: false,
            data: {"country" : document.getElementById("choosecountry").value},
            success: function (data) {
                document.getElementById("stage2").innerHTML = data;

                const elems = document.getElementsByClassName("applicationfile");
                for (var i = 0; i < elems.length; i++) {
                    type.push(elems[i]);
                }
                handleChange();
            },
            error: function (e) {
                console.log(e);
            }
        });
    }

    function handleChange() {
        document.getElementById("stage2").innerHTML = "";
        if (document.getElementById("appType3").checked) {
            for (var i = 0; i < type.length; i++) {
                if(type[i].classList.contains(3)){
                    document.getElementById("stage2").appendChild(type[i]);
                }
            }
        } else if(document.getElementById("appType2").checked) {
            for (var i = 0; i < type.length; i++) {

                if(type[i].classList.contains(2))
                    document.getElementById("stage2").appendChild(type[i]);
            }
        } else if(document.getElementById("appType1").checked) {
            for (var i = 0; i < type.length; i++) {

                if(type[i].classList.contains(1))
                    document.getElementById("stage2").appendChild(type[i]);
            }
        }
    }

    function updateApplication() {
        hideAlerts();
        var form = $('#applicationForm')[0];

        var data = new FormData(form);
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/edit",
            data: data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {
                document.getElementById("alertContainer").innerHTML = successAlert;
            },
            error: function (e) {
                document.getElementById("alertContainer").innerHTML = failAlert;
            }
        });
    }
</script>
<form class="form-horizontal" id="applicationForm" enctype="multipart/form-data">
    <input type="hidden" name="userId" value="${user.userId}">
    <input type="hidden" name="dashboard" value="true">
    <div class="form-group">
        <label class="col-md-3"><spring:message code="update.request" />: </label>
        <div class="col-md-5">
            <label class="radio-inline">
                <input type="radio" name="requestId" value="1" id="requestId1" autocomplete="off"
                       <c:if test="${user.requestId eq 1}">checked</c:if> > <spring:message code="update.request.application"/>
            </label>
            <label class="radio-inline">
                <input type="radio" name="requestId" value="2" id="requestId2" autocomplete="off"
                       <c:if test="${user.requestId eq 2}">checked</c:if>> <spring:message code="update.request.review"/>
            </label>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-3">Başvuru Alanınız: </label>
        <div class="col-md-5">
            <label class="radio-inline">
                <input type="radio" name="appType" value="1" id="appType1" onclick="handleChange();"
                       autocomplete="off"
                       <c:if test="${user.appType eq 1}">checked</c:if> required> Studienkolleg
            </label>
            <label class="radio-inline">
                <input type="radio" name="appType" value="2" id="appType2" onclick="handleChange();"
                       autocomplete="off"
                       <c:if test="${user.appType eq 2}">checked</c:if> required> <spring:message code="bachelor"/>
            </label>
            <label class="radio-inline">
                <input type="radio" name="appType" value="3" id="appType3" onclick="handleChange();"
                       autocomplete="off"
                       <c:if test="${user.appType eq 3}">checked</c:if>> <spring:message code="master"/>
            </label>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-3" for="photo"><spring:message code="update.photo" /></label>
        <div class="col-md-5">
            <input type="file" class="form-control-file" id="photo" name="photo" accept="image/*">
        </div>
    </div>
    <div class="form-group row">
        <label class="col-md-3" for="choosecountry">
            <spring:message code="form_application.country"/>
        </label>
        <div class="col-md-5">
            <select id="choosecountry"
                    class="form-control col-md-7" onchange="countryChange();">
                <option selected value="defopiton"><spring:message code="form_application.choosecountry" /></option>
                <c:forEach items="${countries}" var="country">
                    <option value="${country}">${country}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div id="stage2">
        <!--<c:forEach items="${labels}" var="label">
                                        <div class="form-group row <c:forEach items='${label.types}' var='type'>${type} </c:forEach>">
                                            <label class="col-md-5" for="${label.name}">${label.name}</label>
                                            <input type="hidden" name="file-headline${labels.indexOf(label)}"
                                                   value="${label.name}">
                                            <input type="file" class="form-control-file col-md-7" name="files"
                                                   id="${label.name}"
                                                   accept="application/pdf, image/*" data-parsley-max-file-size="1500"
                                                   data-parsley-trigger="change">
                                        </div>
                                    </c:forEach>-->
    </div>
    <div class="form-group row">
        <label class="col-md-3" for="additional">
            <spring:message code="form_application.additional" />
        </label>
        <div class="col-md-5">
            <textarea name="additional" id="additional" class="form-control">${application.additional}</textarea>
        </div>
    </div>
    <div class="form-group col-md-8">
        <a href="#" onclick="updateApplication();" style="margin-left:5px; float:right" class="btn btn-primary"><spring:message
                code="update.submit"/></a>
        <a href="/dashboard/users" class="btn btn-danger" style="float:right;"><spring:message
                code="update.cancel"/></a>

    </div>
</form>
<script src="/resources/js/jquery.3.2.1.min.js"></script>