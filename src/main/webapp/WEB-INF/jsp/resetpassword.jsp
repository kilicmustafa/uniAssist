<%@ taglib prefix="th" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!doctype html>
<html lang="tr_TR">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB"
          crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp"
          crossorigin="anonymous">
    <link rel="stylesheet" href="/resources/css/style.css">
    <title>Uni-Assistance | Reset Password</title>

    <link rel="stylesheet" href="/resources/css/parsley.css">
    <script src="/resources/js/jquery.3.2.1.min.js"></script>
    <script src="http://parsleyjs.org/dist/parsley.min.js"></script>
    <script>
        function submit() {
            /*var isItOk = true;
            if(document.getElementById("inputEmail").value === "") {
                isItOk = false;
                alert("Email bilginizi giriniz.");
                return;
            } else if(document.getElementById("inputPassword").value === "") {
                isItOk = false;
                alert("Şifre bilginizi giriniz.");
            }*/

            if ($('#loginForm').parsley().validate()){
                document.getElementById("loginForm").submit();
            }
        }
    </script>
</head>

<body>
<jsp:include page="include/navbar.jsp"></jsp:include>

<div class="row" style="margin-top:2.5%;">
    <jsp:include page="include/adsleft.jsp"></jsp:include>
    <div class="col-md-6">
        <div>
            <c:if test="${verification eq true}">
                <div class="alert alert-success" role="alert">
                        ${user.firstName} ${user.lastName} <spring:message code="login.verification" />
                </div>
            </c:if>
            <c:if test="${param.registration eq 'done'}">
                <div class="alert alert-success" role="alert">
                    Üyelik işleminiz tamamlanmıştır, mail hesabınıza gönderilen bağlantıdan onaylama işlemini yaptıktan sonra
                    buradan giriş yapabilirsiniz.
                </div>
            </c:if>
            <form id="loginForm" action="/resetpassword" method="post" data-parsley-validate="true">
                <input type="hidden" name="verificationKey" value="${verificationKey}">
                <div class="form-group row">
                    <label class="col-md-5" for="inputPassword"><spring:message code="login.password" /> </label>
                    <spring:message code="login.placeholder.password" var="loginplaceholderpassword"/>
                    <input name="password" type="password" class="col-md-7 form-control" id="inputPassword"
                           placeholder="${loginplaceholderpassword}" data-parsley-trigger="change" required=""/>
                </div>
                <div class="form-group row">
                    <label class="col-md-5" for="passwordAgain"><spring:message code="register.password.again" /></label>
                    <input name="passwordAgain" type="password" class="col-md-7 form-control" id="passwordAgain"
                           placeholder="<spring:message code="login.placeholder.password" />"
                           data-toggle="tooltip" data-placement="top" title="<spring:message code="register.password.again.hint" />"
                           data-parsley-equalto="#inputPassword"
                           data-parsley-trigger="change" data-parsley-minlength="2" data-parsley-maxlength="12" required="">
                    <!--
                     <span style="visibility: hidden;" id="passwordagainerror" class="error"><spring:message code="register.password.again.error" /></span>
                     -->
                </div>
            </form>
            <c:if test="${param.fail eq true}">
                <div class="alert alert-danger" role="alert">
                    <spring:message code="login.error" />
                </div>
            </c:if>
            <div class="row">
                <div class="col-md-12">
                    <button style="margin-left:5px; float:right;" onclick="submit()" class="btn btn-primary"><spring:message code="login.button" /></button>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="include/adsright.jsp"></jsp:include>
</div>

<jsp:include page="include/footer.jsp"></jsp:include>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T"
        crossorigin="anonymous"></script>
</body>

</html>