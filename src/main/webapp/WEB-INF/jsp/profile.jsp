<%@ page import="java.text.SimpleDateFormat" %>
<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
          integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB"
          crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css"
          integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp"
          crossorigin="anonymous">
    <script src="/resources/js/exif.js"></script>
    <title>Uni-Assistance | Profile</title>

    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <style>
        body {
            overflow-x: hidden;
        }

        @media only screen and (min-width: 768px) {
            #formContainer {
                padding-left: 25%;
                padding-right: 25%;
            }
        }

        @media only screen and (max-width: 768px) {
            #formContainer {
            }
        }

        .bs-wizard {
            margin-top: 40px;
        }

        /*Form Wizard*/
        .bs-wizard {
            border-bottom: solid 1px #e0e0e0;
            padding: 0 0 10px 0;
        }

        .bs-wizard > .bs-wizard-step {
            padding: 0;
            position: relative;
        }

        .bs-wizard > .bs-wizard-step + .bs-wizard-step {
        }

        .bs-wizard > .bs-wizard-step .bs-wizard-stepnum {
            color: #595959;
            font-size: 10px;
            margin-bottom: 5px;
        }

        .bs-wizard > .bs-wizard-step .bs-wizard-info {
            color: #999;
            font-size: 14px;
        }

        .bs-wizard > .bs-wizard-step > .bs-wizard-dot {
            position: absolute;
            width: 30px;
            height: 30px;
            display: block;
            background: #7ac6fb;
            top: 45px;
            left: 50%;
            margin-top: -15px;
            margin-left: -15px;
            border-radius: 50%;
        }

        .bs-wizard > .bs-wizard-step > .bs-wizard-dot:after {
            content: ' ';
            width: 14px;
            height: 14px;
            background: #7787fb;
            border-radius: 50px;
            position: absolute;
            top: 8px;
            left: 8px;
        }

        .bs-wizard > .bs-wizard-step > .progress {
            position: relative;
            border-radius: 0px;
            height: 8px;
            box-shadow: none;
            margin: 20px 0;
        }

        .bs-wizard > .bs-wizard-step > .progress > .progress-bar {
            width: 0px;
            box-shadow: none;
            background: #75c6fb;
        }

        .bs-wizard > .bs-wizard-step.complete > .progress > .progress-bar {
            width: 100%;
        }

        .bs-wizard > .bs-wizard-step.active > .progress > .progress-bar {
            width: 50%;
        }

        .bs-wizard > .bs-wizard-step:first-child.active > .progress > .progress-bar {
            width: 0%;
        }

        .bs-wizard > .bs-wizard-step:last-child.active > .progress > .progress-bar {
            width: 100%;
        }

        .bs-wizard > .bs-wizard-step.disabled > .bs-wizard-dot {
            background-color: #f5f5f5;
        }

        .bs-wizard > .bs-wizard-step.disabled > .bs-wizard-dot:after {
            opacity: 0;
        }

        .bs-wizard > .bs-wizard-step:first-child > .progress {
            left: 50%;
            width: 50%;
        }

        .bs-wizard > .bs-wizard-step:last-child > .progress {
            width: 50%;
        }

        .bs-wizard > .bs-wizard-step.disabled a.bs-wizard-dot {
            pointer-events: none;
        }

        .top-disabled {
            color: gray;
        }

        /*END Form Wizard*/
    </style>
    <script>
        function updateApplicationState(userId, doc) {
            $.ajax({
                type: "POST",
                url: "/dashboard/applicationstates/updatefromprofile",
                data: {
                    userId : userId,
                    appStateId: doc.id
                },
                success: function (data) {
                    location.reload();
                },
                error: function (data) {
                    location.reload();
                }
            });
        }
    </script>
</head>

<body>
<jsp:include page="include/navbar.jsp"></jsp:include>
<script>
    window.onload = function() {
        if(window.matchMedia("(max-width: 768)").matches === false) {
            var imageElement = document.getElementById("profile-photo");
            EXIF.getData(imageElement, function() {
                var orientation = EXIF.getTag(this, "Orientation");

                if(orientation === 6)
                    $(imageElement).css('transform', 'rotate(90deg)')
            });
        }
        if(document.getElementById("payment") != null) {
            $('[data-toggle="tooltip"]').tooltip()
            $('#payment').tooltip('show');
        }
    }
</script>
<div class="py-5 row">
    <div class="row" style="width: 100%; margin-top:2.5%;">
        <jsp:include page="include/adsleft.jsp"></jsp:include>
        <div class="col-md-6">
            <c:if test="${(sessionScope.get('email') eq user.email) eq false}">
                <div class="row">
                    <div class="col-md-3"></div>
                    <div class="col-md-6">
                        <center>
                            <c:forEach var="as" items="${applicationState}">
                                <a href="#" id="${as.applicationStateID}"
                                   class='<c:if test="${as.applicationStateID > applicationStateId}">top-disabled</c:if>'
                                   <%--onclick="updateApplicationState(${user.userId}, this)"--%>
                                   style="font-size: 30px; text-decoration: none;" data-toggle="modal" data-target="#modal${as.applicationStateID}">
                                    <i class="fas fa-star"></i>
                                </a>

                                <!-- Modal -->
                                <div class="modal fade" id="modal${as.applicationStateID}" tabindex="-1" role="dialog" aria-labelledby="modal${as.applicationStateID}" aria-hidden="true">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="modalLabel">Modal title</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                    ${user.userId} numaralı kullanıcının başvuru durumunu "${as.name}" olarak güncellemek istediğinize emin misiniz?
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                <button id="${as.applicationStateID}" type="button" onclick="updateApplicationState(${user.userId}, this)" class="btn btn-primary">Save changes</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </center>
                    </div>
                    <div class="col-md-3"></div>
                </div>
            </c:if>
            <div class="col-12" style="border: 1px solid #007bff;">
                <div class="row">
                    <div class="col-12" style="background-color:#007bff; height: 30px; color:white">
                        <p style="text-indent: 30px; line-height: 30px;"><spring:message code="profile.informations" /></p>
                    </div>
                </div>
                <div class="row" style="margin-top: 2.5%;">
                    <div class="col-md-12">
                        <center style="float:right;">
                            <img id="profile-photo" class="img-circle" width="150" height="150"
                                 src="<c:choose>
                                                <c:when test='${photoDocument eq null or photoDocument.documentFileName eq ""}'>/resources/images/default-profile.png</c:when>
                                                <c:otherwise>/source/${photoDocument.documentFileName}?documentId=${photoDocument.documentId}&source=photo</c:otherwise>
                                            </c:choose>">
                        </center>
                        <div class="col-md-8">
                            <table class="table">
                                <tbody>
                                <tr>
                                    <td><spring:message code="profile.id" /></td>
                                    <td>${user.userId}</td>
                                </tr>
                                <tr>
                                    <td><spring:message code="register.name" /></td>
                                    <td>${user.firstName}</td>
                                </tr>
                                <tr>
                                    <td><spring:message code="register.lastname" /></td>
                                    <td>${user.lastName}</td>
                                </tr>
                                <tr>
                                    <td>Email</td>
                                    <td>${user.email}</td>
                                </tr>
                                <tr>
                                    <td><spring:message code="update.phone" /></td>
                                    <td>${user.phoneNumber}</td>
                                </tr>
                                <tr>
                                    <td><spring:message code="dashboard.registrationdate" /></td>
                                    <td><fmt:formatDate  value="${user.registrationDate}" pattern="dd.MM.YYYY"/></td>
                                </tr>
                                <tr>
                                    <td><spring:message code="register.birthdate" /></td>
                                    <td><fmt:formatDate  value="${user.birthDate}" pattern="dd.MM.YYYY"/></td>
                                </tr>
                                <tr>
                                    <td><spring:message code="update.birthplace" /></td>
                                    <td>${user.city} <c:if test="${user.city != null && !user.city.equals('')}">/</c:if> ${user.country}</td>
                                </tr>
                                <tr>
                                    <td><spring:message code="update.gender" /></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${user.gender eq 'M'}"><spring:message code="update.male" /></c:when>
                                            <c:when test="${user.gender eq 'F'}"><spring:message code="update.female" /></c:when>
                                        </c:choose>
                                    </td>
                                </tr>
                                <tr>
                                    <td><spring:message code="applytpye" /></td>
                                    <td><c:if test="${applicationType.typeName != null}"><spring:message code="${applicationType.typeName.replace(' ', '')}" /></c:if></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-bottom: 2.5%;">
                    <div class="col-12">
                        <c:choose>
                            <c:when test="${sessionScope.get('email') eq user.email}">
                                <c:set var="editUrl" value="/edit" />
                                <c:set var="changePasswordUrl" value="/profile/changepassword"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="editUrl" value="/dashboard/users/settings/${user.userId}" />
                                <c:set var="changePasswordUrl" value="/dashboard/users/settings/${user.userId}"/>
                            </c:otherwise>
                        </c:choose>
                        <a style="float:right!important; margin-left:5px;" href="${editUrl}" class="btn btn-primary"><spring:message code="profile.edit" /></a>
                        <c:if test="${editUrl eq '/edit'}">
                            <a style="float:right!important; line-height: 35px;" href="${changePasswordUrl}" ><spring:message code="profile.password" /></a>
                        </c:if>

                    </div>
                </div>
            </div>
            <c:if test="${applicationDocuments.size() > 0}">
                <div class="">
                    <div class="col-md-12" style="border: 1px solid #007bff;">
                        <div class="row">
                            <div class="col-md-12" style="background-color:#007bff; height: 30px; color:white">
                                <p style="text-indent: 30px; line-height: 30px;"><spring:message code="applyfiles" /></p>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 2.5%;">
                            <div class="col-md-12">
                                <table class="table">
                                    <tbody>
                                    <c:forEach items="${applicationDocuments}" var="applicationDocument">
                                        <c:if test="${!applicationDocument.documentName.equals('Photo')}">
                                            <tr>
                                                <td>${applicationDocument.documentName}</td>
                                                <td><a class="lead"
                                                       href="/source/${applicationDocument.documentFileName}?documentId=${applicationDocument.documentId}">${applicationDocument.documentFileName}</a>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
            <c:if test="${!(additional.additional eq null || additional.additional eq '')}">
                <div class="form-group">
                    <textarea class="form-control" rows="3" readonly>${additional.additional}</textarea>
                </div>
            </c:if>
            <c:if test="${!(note.forUser eq null || note.forUser eq '')}">
                <div class="form-group">
                    <label for="note"><spring:message code="authorizednote" /></label>
                    <textarea class="form-control" id="note" name="note" rows="3"
                              readonly>${note.forUser}</textarea>
                </div>
            </c:if>
            <c:if test="${!(note.forUser eq null || note.forUser eq '') && (sessionScope.get('role') eq 1 || sessionScope.get('role') eq 3)}">
                <div class="form-group">
                    <label for="note"><spring:message code="specialnote" /></label>
                    <textarea class="form-control" id="forUs" name="note" rows="3" readonly>${note.forUs}</textarea>
                </div>
            </c:if>
            <c:if test="${documents.size() > 0}">
                <div class="">
                    <div class="col-md-12" style="border: 1px solid #007bff;">
                        <div class="row">
                            <div class="col-md-12" style="background-color:#007bff; height: 30px; color:white">
                                <p style="text-indent: 30px; line-height: 30px;"><spring:message code="authorizedfiles" /></p>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 2.5%;">
                            <div class="col-md-12">
                                <table class="table">
                                    <tbody>
                                    <c:forEach items="${documents}" var="document">
                                        <tr>
                                            <td>${document.documentName}</td>
                                            <td>
                                                <a class="lead"
                                                   href="/document/${document.documentFileName}?documentId=${document.documentId}&source=">${document.documentFileName}</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
        <jsp:include page="include/adsright.jsp"></jsp:include>

        <div class="container">
            <div class="row bs-wizard" style="border-bottom:0; margin-top: 100px">
                <div class="col-md-1"></div>
                <c:forEach var="as" items="${applicationState}">
                    <div class="col-md-2 bs-wizard-step
                                <c:choose>
                                    <c:when test="${as.applicationStateID <= applicationStateId}">complete</c:when>
                                    <c:otherwise>disabled</c:otherwise>
                                </c:choose>">
                        <div class="text-center bs-wizard-stepnum"><spring:message code="step${as.applicationStateID}.headline" /></div>
                        <div class="progress">
                            <div class="progress-bar"></div>
                        </div>
                        <a href="#" class="bs-wizard-dot"></a>
                        <div class="bs-wizard-info text-center"><spring:message code="step${as.applicationStateID}.content" /></div>
                    </div>
                </c:forEach>

            </div>
        </div>
    </div>

</div>

<jsp:include page="include/footer.jsp"></jsp:include>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="/resources/js/jquery.3.2.1.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
        integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"
        integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T"
        crossorigin="anonymous"></script>
<script>
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
    });
</script>
</body>
</html>