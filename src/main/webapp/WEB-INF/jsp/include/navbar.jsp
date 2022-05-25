<%@ taglib prefix="th" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<link href="https://fonts.googleapis.com/css?family=Rubik" rel="stylesheet">
<style>
    body {
        font-family: 'Rubik', sans-serif;
        overflow-x: hidden;
        width: 100vw;
        margin: 0;
    }
</style>
<div id="langSelector" style="float:right; margin-top: 2.5%; margin-right: 2.5%;">
    <a href="?lang=tr">
        <img width="25" src="/resources/images/if_Turkey_92389.png" />
    </a>
    <a href="?lang=en">
        <img width="25" src="/resources/images/if_United-Kingdom_92403.png" />
    </a>
    <a href="?lang=de">
        <img width="25" src="/resources/images/if_Germany_92095.png" />
    </a>
    <a href="?lang=cn">
        <img width="25" src="/resources/images/if_China_92023.png" />
    </a>
</div>

<div class="clearfix">

</div>

<nav class="navbar navbar-expand-lg navbar-light bg-light" style="    box-shadow: 5px 1px 5px 1px grey; z-index: 999;">

    <a href="/"><img class="navbar-brand" src="/resources/images/uni-assist_logo1.png" width="325" alt=""></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
            aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
<style>
    #navbarSupportedContent .nav-item {
        display: inline-block;
        list-style: outside none none;
        margin: 0.5em 1.5em;
        padding: 0;
    }
    #navbarSupportedContent .nav-item a {
        padding: 0.3em 0;

        position: relative;
        text-decoration: none;
        display: inline-block;
    }
    #navbarSupportedContent .nav-item a:before,
    #navbarSupportedContent .nav-item a:after {
        height: 3px;
        position: absolute;
        content: '';
        -webkit-transition: all 0.35s ease;
        transition: all 0.35s ease;
        background-color: #ff4444;
        width: 0;
    }
    #navbarSupportedContent .nav-item a:before {
        top: 0;
        left: 0;
    }
    #navbarSupportedContent .nav-item a:after {
        bottom: 0;
        right: 0;
    }
    #navbarSupportedContent .nav-item a:hover,
    #navbarSupportedContent .nav-item .current a {
        color: black;
    }
    #navbarSupportedContent .nav-item a:hover:before,
    #navbarSupportedContent .nav-item .current a:before,
    #navbarSupportedContent .nav-item a:hover:after,
    #navbarSupportedContent .nav-item .current a:after {
        width: 100%;
    }
</style>
    <div class="collapse navbar-collapse" id="navbarSupportedContent" style="margin-left: 2.5%;">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="/"><spring:message code="navbar.home" />
                    <span class="sr-only">(current)</span>
                </a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="/how-to-apply"><spring:message code="navbar.howtoapply" />
                    <span class="sr-only">(current)</span>
                </a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="/faq"><spring:message code="navbar.faq" />
                    <span class="sr-only">(current)</span>
                </a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="/hakkimizda"><spring:message code="navbar.about" />
                    <span class="sr-only">(current)</span>
                </a>
            </li>
            <c:if test="${loginState == true and appState eq 2}">
                <li class="nav-item active">
                    <a id="payment" style="color:mediumseagreen;" class="nav-link" href="/payment"
                       data-toggle="tooltip" data-placement="top" title="Dosyalarınız tarafımıza iletildi, ödeme yapmak için tıklayın.">
                        <spring:message code="navbar.payment" />
                        <span class="sr-only">(current)</span>
                    </a>
                </li>
            </c:if>
        </ul>
        <form class="form-inline my-2 my-lg-0">
            <c:choose>
                <c:when test="${loginState == true}">
                    <c:if test="${role eq 1 or role eq 3}">
                        <a class="nav-link" href="/dashboard"><spring:message code="navbar.dashboard" /> </a>
                    </c:if>
                    <a class="nav-link" href="/profile"><spring:message code="navbar.profile" /> </a>
                    <a class="nav-link" href="/exit"><spring:message code="navbar.exit" /></a>
                </c:when>
                <c:otherwise>
                    <a class="nav-link" href="/login"><spring:message code="navbar.login" /></a>
                    <a class="nav-link" href="/register"><spring:message code="navbar.register" /></a>
                </c:otherwise>
            </c:choose>
        </form>
    </div>
</nav>