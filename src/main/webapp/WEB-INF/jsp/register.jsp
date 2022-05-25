<%@ taglib prefix="th" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB"
          crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp"
          crossorigin="anonymous">
    <link rel="stylesheet" href="/resources/css/parsley.css">
    <title>Uni-Assistance | Register</title>
    <style>


        #stage3 {
            visibility: hidden;
        }

        .error {
            color:red;
        }
    </style>

    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="http://parsleyjs.org/dist/parsley.min.js"></script>
    <script src="/resources/js/script.js"></script>
    <script>
        $( function() {
            $( "#datepicker" ).datepicker();
        } );
    </script>

</head>

<body>
<jsp:include page="include/navbar.jsp"></jsp:include>

<c:if test="${param.fail eq 'mail'}">
    <div style="text-align: center;">
        <h3 class="h3">Email hesabı zaten kayıtlı.</h3>
    </div>
</c:if>

<div class="row" style="margin-top: 2.5%;">
    <jsp:include page="include/adsleft.jsp"></jsp:include>
    <div class="col-md-6">
        <form id="registerForm" action="/register" method="post" enctype="multipart/form-data" data-parsley-validate="">
            <div id="stage1">
                <div class="form-group row">
                    <label class="col-md-5" for="email"><spring:message code="login.email" /></label>
                    <spring:message code="login.placeholder.email" var="placeholderemail"/>
                    <input type="email" name="email" class="col-md-7 form-control" id="email" placeholder="${placeholderemail}"  data-parsley-trigger="change" required=""/>
                </div>
                <div class="row form-group">
                    <label class="col-md-5" for="firstName"><spring:message code="register.name" /></label>
                    <spring:message code="register.placeholder.name" var="placeholdername"/>
                    <input name="firstName" id="firstName" type="text" class="col-md-7 form-control" placeholder="${placeholdername}"
                          data-parsley-trigger="change" data-parsley-minlength="2" data-parsley-maxlength="15" required=""/>
                </div>
                <div class="form-group row">
                    <label class="col-md-5" for="lastName"><spring:message code="register.lastname" /></label>
                    <spring:message code="register.placeholder.lastname" var="placeholderlastname"/>
                    <input name="lastName" type="text" class="form-control col-md-7" id="lastName" placeholder="${placeholderlastname}"
                           data-parsley-trigger="change" data-parsley-minlength="2" data-parsley-maxlength="15" required=""/>
                </div>
                <div class="form-group row">
                    <label class="col-md-5" for="inputPassword"><spring:message code="login.password" /></label>
                    <spring:message code="register.password.hint" var="registerpasshint"/>
                    <spring:message code="login.placeholder.password" var="loginplaceholderpass"/>
                    <input name="password" type="password" class="col-md-7 form-control" id="inputPassword"
                                placeholder="${loginplaceholderpass}"
                                data-toggle="tooltip" data-placement="top" title="${registerpasshint}"
                           data-parsley-trigger="change" data-parsley-minlength="8" data-parsley-maxlength="12" required=""/>
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

                <!--<div class="form-group">
                    <select id="requestId" name="requestId" class="custom-select">
                        <option selected>İsteğinizi seçiniz.</option>
                        <option value="1">Başvuru</option>
                        <option value="2">İnceleme</option>
                    </select>
                </div>

                <div class="form-group">
                    <select id="appType" name="appType" class="custom-select">
                        <option selected>Başvuru alanınızı seçiniz.</option>
                        <option value="1">Lisans</option>
                        <option value="2">Yüksek Lisans</option>
                    </select>
                </div>-->
            </div>
        </form>
        <div class="row">
            <!--<div class="col-sm-6">
                <button id="preStage" onclick="changeStage(-1)" class="btn btn-primary disabled">Önceki</button>
            </div>-->
            <div class="col-sm-12">
                <button style="float:right;" onclick="sendRegisterForm();" id="nextStage" class="btn btn-primary"><spring:message code="register.button"/></button>
            </div>
        </div>

    </div>
    <jsp:include page="include/adsright.jsp"></jsp:include>
</div>

<jsp:include page="include/footer.jsp"></jsp:include>


<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T"
        crossorigin="anonymous"></script>
<script>
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
    });
</script>
</body>

</html>