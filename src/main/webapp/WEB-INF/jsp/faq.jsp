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
    <title>Uni-Assistance | FAQ</title>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
</head>

<body>
<jsp:include page="include/navbar.jsp"></jsp:include>

<div class="row" style="margin-top:2.5%; margin-bottom: 2.5%; margin-left: 0 !important; margin-right: 0 !important;">
    <jsp:include page="include/adsleft.jsp"></jsp:include>
    <div class="col-md-6">
        <div class="container">
            <p class="lead"><spring:message code="navbar.faq"/></p>

            <br/>

            <div class="alert alert-warning alert-dismissible" role="alert">
                <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span
                        class="sr-only"><spring:message code="close"/></span></button>
                <spring:message code="faq.info"/>
            </div>

            <br/>
            <div class="" id="accordion">
                <div class="faqHeader"><spring:message code="faq.generalquestions"/></div>
                <c:forEach begin="1" end="14" varStatus="loop">
                    <c:if test="${((pageContext.response.locale eq 'tr') && loop.index < 14) || !(pageContext.response.locale eq 'tr')}">
                        <div class="card ">
                            <div class="card-header">
                                <h4 class="card-header">
                                    <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion"
                                       href="#collapse${loop.index}"><spring:message code="faq.question${loop.index}"/>?</a>
                                </h4>
                            </div>
                            <div id="collapse${loop.index}" class="panel-collapse collapse">
                                <div class="card-block">
                                    <div class="container">
                                        <spring:message code="faq.answer${loop.index}"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>

            <style>
                .faqHeader {
                    font-size: 18px;
                    margin: 20px;
                }

                .accordion-toggle {
                    color: black;
                    font-size: 16px;
                }

                .panel-heading [data-toggle="collapse"]:after {
                    font-family: 'Glyphicons Halflings';
                    content: "e072"; /* "play" icon */
                    float: right;
                    color: #F58723;
                    font-size: 14px;
                    line-height: 22px;
                    /* rotate "play" icon from > (right arrow) to down arrow */
                    -webkit-transform: rotate(-90deg);
                    -moz-transform: rotate(-90deg);
                    -ms-transform: rotate(-90deg);
                    -o-transform: rotate(-90deg);
                    transform: rotate(-90deg);
                }

                .panel-heading [data-toggle="collapse"].collapsed:after {
                    /* rotate "play" icon from > (right arrow) to ^ (up arrow) */
                    -webkit-transform: rotate(90deg);
                    -moz-transform: rotate(90deg);
                    -ms-transform: rotate(90deg);
                    -o-transform: rotate(90deg);
                    transform: rotate(90deg);
                    color: #454444;
                }
            </style>

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