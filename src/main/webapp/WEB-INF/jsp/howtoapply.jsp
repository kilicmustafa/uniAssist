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
    <title>Uni-Assistance | How To Apply?</title>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

    <style>
        #steps .box {
            -webkit-box-shadow: 0px 12px 6px -6px rgba(41,41,41,0.25);
            -moz-box-shadow: 0px 12px 6px -6px rgba(41,41,41,0.25);
            box-shadow: 0px 12px 6px -6px rgba(41,41,41,0.25);  padding: 0;
        }
        .step1 {

        }
        .step2 .animated {
            -webkit-animation-delay: 1s;
            animation-delay: 1s;
            position: relative;
            top: -6px;
        }
        .step3 .animated {
            -webkit-animation-delay: 2s;
            animation-delay: 2s;
            position:relative;
            top: -12px;
        }
        .step4 .animated {
            -webkit-animation-delay: 3s;
            animation-delay: 3s;
            position: relative;
            top: -18px;
        }
        .step5 .animated {
            -webkit-animation-delay: 4s;
            animation-delay: 4s;
            position: relative;
            top: -24px;
        }
        .shape {
            width: 150px;
            height: 120px;
            -webkit-transform: skew(20deg);
            -moz-transform: skew(20deg);
            -o-transform: skew(20deg);
            -webkit-box-shadow: 0px 12px 30px -6px rgba(41,41,41,0.25);
            -moz-box-shadow: 0px 12px 30px -6px rgba(41,41,41,0.25);
            box-shadow: 0px 12px 30px -6px rgba(41,41,41,0.25);
            top: 10px;
            left: 8px;
            text-align: center;
        }
        #steps .shape-1 .shape{
            background: #e74c3c;
        }
        #steps .shape-1 .material-icons {
            color: #e74c3c;
        }
        #steps .shape-2 .shape{
            background: #34495e;
        }
        #steps .shape-2 .material-icons {
            color: #34495e;
        }
        #steps .shape-3 .shape {
            background: #f39c12;
        }
        #steps .shape-3 .material-icons {
            color: #f39c12;
        }
        #steps .shape-4 .shape {
            background: #3498db;
        }
        #steps .shape-4 .material-icons {
            color: #3498db;
        }
        #steps .shape-5 .shape{
            background: #28a745;
        }
        #steps .shape-5 .material-icons {
            color: #28a745;
        }
        #steps .number {
            -webkit-transform: skew(-20deg);
            -moz-transform: skew(-20deg);
            -o-transform: skew(-20deg);
        }
        #steps h1 {
            color: #fff;
            font-weight: 700;
            letter-spacing: 2px;
            padding-top: 8px;
            transform:scale(2,3);
            -webkit-transform:scale(2,3);
            -moz-transform:scale(2,3);
            -ms-transform:scale(2,3);
            -o-transform:scale(2,3);
        }
        #steps .box p {
            font-weight: 300;
            padding-top: 25px;
        }
        #steps .md-56 {
            font-size: 56px;
            padding-top: 30px;
        }

        #steps p {
            margin-left: 15px;
        }
    </style>
</head>

<body>
<jsp:include page="include/navbar.jsp"></jsp:include>

<div class="row" style="margin-top:2.5%; margin-bottom: 2.5%; margin-right: 0 !important; margin-left: 0 !important;">
    <jsp:include page="include/adsleft.jsp"></jsp:include>
    <div class="col-md-6">


        <div class="container">
            <div class="container" style="text-align: center;">
                <h2><spring:message code="footer.howtoapply" /></h2>
            </div>

            <div id="steps" class="row">
                <div class="col-md-12 step1">
                    <div class="row box shape-1 animated bounceInLeft">
                        <div class="col-md-4 shape">
                            <div class="number">
                                <h1>01</h1>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <p><spring:message code="howtoapply.step1" /></p>
                        </div>
                        <div class="col-md-2 text-center">
                            <i class="material-icons fa fa-save md-56"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 step2">
                    <div class="row box shape-2 animated bounceInRight">
                        <div class="col-md-4 shape">
                            <div class="number">
                                <h1>02</h1>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <p><spring:message code="howtoapply.step2" /></p>
                        </div>
                        <div class="col-md-2 text-center">
                            <i class="material-icons fa fa-envelope-square md-56"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 step3">
                    <div class="row box shape-3 animated bounceInLeft">
                        <div class="col-md-4 shape">
                            <div class="number">
                                <h1>03</h1>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <p><spring:message code="howtoapply.step3" /></p>
                        </div>
                        <div class="col-md-2 text-center">
                            <i class="material-icons fa fa-file md-56"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 step4">
                    <div class="row box shape-4 animated bounceInRight">
                        <div class="col-md-4 shape">
                            <div class="number">
                                <h1>04</h1>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <p><spring:message code="howtoapply.step4" /></p>
                        </div>
                        <div class="col-md-2 text-center">
                            <i class="material-icons fa fa-credit-card md-56"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 step5">
                    <div class="row box shape-5 animated bounceInRight">
                        <div class="col-md-4 shape">
                            <div class="number">
                                <h1>05</h1>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <p><spring:message code="howtoapply.step5" /></p>
                        </div>
                        <div class="col-md-2 text-center">
                            <i class="material-icons fa fa-check md-56"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="jumbotron" style="background: white; box-shadow: 0px 0px 0px 1px darkgrey;">
                <h1 class="display-4"><spring:message code="applynow"/></h1>
                <p class="lead"><spring:message code="applynow.content"/></p>
                <hr class="my-4">
                <p><spring:message code="applynow.content2"/></p>
                <a class="btn btn-primary btn-lg" href="/register" role="button"><spring:message
                        code="navbar.register"/></a>
            </div>
        </div>
    </div>
    <jsp:include page="include/adsright.jsp"></jsp:include>
</div>

<jsp:include page="include/footer.jsp"></jsp:include>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
        integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"
        integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T"
        crossorigin="anonymous"></script>
</body>

</html>