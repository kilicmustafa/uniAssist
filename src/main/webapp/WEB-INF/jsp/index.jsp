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
    <title>Uni-Assistance | Home</title>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
    <style>
        .carousel-indicators .active {
            background-color: transparent;
        }

        .hovereffect {
            width: 100%;
            float: left;
            overflow: hidden;
            position: relative;
            text-align: center;
            cursor: default;
        }

        .hovereffect .overlay {
            width: 100%;
            height: 100%;
            position: absolute;
            overflow: hidden;
            top: 27%;
            left: 0;
            padding: 50px 20px;
        }

        .hovereffect img {
            display: block;
            position: relative;
            max-width: none;
            width: calc(100% + 20px);
            -webkit-transition: opacity 0.35s, -webkit-transform 0.35s;
            transition: opacity 0.35s, transform 0.35s;
            -webkit-transform: translate3d(-10px, 0, 0);
            transform: translate3d(-10px, 0, 0);
            -webkit-backface-visibility: hidden;
            backface-visibility: hidden;
        }

        .hovereffect:hover img {
            opacity: 0.4;
            filter: alpha(opacity=40);
            -webkit-transform: translate3d(0, 0, 0);
            transform: translate3d(0, 0, 0);
        }

        .hovereffect h2 {
            text-transform: uppercase;
            color: #fff;
            text-align: center;
            position: relative;
            font-size: 17px;
            overflow: hidden;
            padding: 0.5em 0;
            background-color: transparent;
        }

        .hovereffect h2:after {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 2px;
            background: #fff;
            content: '';
            -webkit-transition: -webkit-transform 0.35s;
            transition: transform 0.35s;
            -webkit-transform: translate3d(-100%, 0, 0);
            transform: translate3d(-100%, 0, 0);
        }

        .hovereffect:hover h2:after {
            -webkit-transform: translate3d(0, 0, 0);
            transform: translate3d(0, 0, 0);
        }

        .hovereffect a, .hovereffect p {
            color: #FFF;
            opacity: 0;
            filter: alpha(opacity=0);
            -webkit-transition: opacity 0.35s, -webkit-transform 0.35s;
            transition: opacity 0.35s, transform 0.35s;
            -webkit-transform: translate3d(100%, 0, 0);
            transform: translate3d(100%, 0, 0);
        }

        .hovereffect:hover a, .hovereffect:hover p {
            opacity: 1;
            filter: alpha(opacity=100);
            -webkit-transform: translate3d(0, 0, 0);
            transform: translate3d(0, 0, 0);
        }

        .card {
            box-shadow: 0px 0px 1px 1px darkgrey;
        }

        @media only screen and (max-width: 768px) {
            .carousel-indicators {
                bottom: 75px;
            }
        }

        @media only screen and (min-width: 768px) {
            .carousel-indicators {
                bottom: 250px;
            }
        }
    </style>
</head>

<body style="overflow-x: hidden;">
<jsp:include page="include/navbar.jsp"></jsp:include>

<div id="carouselExampleIndicators" class="carousel slide" style="width: 100%;" data-ride="carousel">
    <ol class="carousel-indicators">
        <center>
            <div class="col-md-12 hover-slide text-center">
                <h1 style="
    color: black;
    font-size: 32px;
"><spring:message code="carousel.content"/></h1>
                <a class="btn btn-dark" href="/how-to-apply"><spring:message code="navbar.inner.carousel"/></a>
            </div>
        </center>
    </ol>


    <div class="carousel-inner">
        <div class="carousel-item active">
            <img class="d-block w-100" src="/resources/images/indexbg.gif" style="width:640px;height:500px"
                 alt="First slide">
        </div>
    </div>
</div>

<div class="container">
    <div class="row" style="margin-top: 5%;">
        <div class="col-md-1"></div>
        <div class="col-md-10">
            <p><spring:message code="paragraph1"/>
            </p>
            <p><spring:message code="paragraph2"/></p>
        </div>
        <div class="col-md-1"></div>
    </div>
    <div class="row" style="margin-top: 5%;">
        <div class="col-md-2">
            <img width="175" height="125" src="/resources/images/countries/gb.png">
        </div>
        <div class="col-md-2">
            <img width="175" height="125" src="/resources/images/countries/de.png">
        </div>
        <div class="col-md-2">
            <img width="175" height="125" src="/resources/images/countries/us.png">
        </div>
        <div class="col-md-2">
            <img width="175" height="125" src="/resources/images/countries/ca.png">
        </div>
        <div class="col-md-2">
            <img width="175" height="125" src="/resources/images/countries/fr.png">
        </div>
        <div class="col-md-2">
            <img width="175" height="125" src="/resources/images/countries/it.png">
        </div>
    </div>
</div>

<main role="main" class="container">
    <center style="margin-top: 5%;">
        <div class="card-deck">
            <div class="card">
                <div class="hovereffect" style="background: #ff4444;">
                    <img class="card-img-top" src="/resources/images/test1.gif" height="300"
                         alt="<spring:message code='card.takeinfo' />">
                    <div class="overlay">
                        <h2><spring:message code="card.takeinfo"/></h2>
                        <p class=""><a href="/how-to-apply"><spring:message code="navbar.howtoapply"/></a></p>
                    </div>
                </div>
                <div class="card-body">
                    <h5 class="card-title"><spring:message code="card.takeinfo"/></h5>
                    <p class="card-text"><spring:message code="card.takeinfo.content"/></p>
                </div>
            </div>
            <div class="card">
                <div class="hovereffect" style="background: #cfca41;">
                    <img class="card-img-top" src="/resources/images/test2.gif" height="300"
                         alt="<spring:message code='card.onlineapply' />">
                    <div class="overlay">
                        <h2><spring:message code="card.onlineapply"/></h2>
                        <p class=""><a href="/register"><spring:message code="navbar.register"/></a></p>
                    </div>
                </div>
                <div class="card-body">
                    <h5 class="card-title"><spring:message code="card.onlineapply"/></h5>
                    <p class="card-text"><spring:message code="card.onlineapply.content"/></p>
                </div>
            </div>
            <div class="card">
                <div class="hovereffect" style="background: #000;">
                    <img class="card-img-top" src="/resources/images/test3.gif" height="300"
                         alt="<spring:message code='card.applicationstate' />">
                    <div class="overlay">
                        <h2><spring:message code="card.applicationstate"/></h2>
                        <p class=""><a href="/profile"><spring:message code="navbar.profile"/></a></p>
                    </div>
                </div>
                <div class="card-body">
                    <h5 class="card-title"><spring:message code="card.applicationstate"/></h5>
                    <p class="card-text"><spring:message code="card.applicationstate.content"/></p>
                </div>
            </div>
        </div>
    </center>

</main>

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