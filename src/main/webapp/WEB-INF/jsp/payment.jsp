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
    <title>Uni-Assistance | Payment</title>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

    <style>
        #paypal-form form {
            width: 50%;
            display: block;
            margin-left: auto;
            margin-right: auto;
        }
    </style>
</head>

<body>
<jsp:include page="include/navbar.jsp"></jsp:include>

<div class="">

    <div class="row" style="margin-top:2.5%; margin-bottom: 2.5%; margin-left: 0 !important; margin-right: 0 !important;">
        <jsp:include page="include/adsleft.jsp"></jsp:include>
        <div class="col-md-6">
            <center>
                <c:choose>
                    <c:when test="${user.requestId eq 2}">
                        <div class="alert alert-info" role="alert">
                            Dosyalarınızın incelenmesi yönündeki isteğiniz için ödemeniz gereken ücret 30 Euro.
                            Ödemenizi gerçekleştirirken açıklama kısmında profilinizde yer alan müşteri numaranızı eklemeyi unutmayınız.
                        </div>
                    </c:when>
                    <c:when test="${user.requestId eq 1}">
                        <c:choose>
                            <c:when test="${user.appType eq 1}">
                                <div class="alert alert-info" role="alert">
                                    Studienkolleg başvurunuzun işleme alınabilmesi için ödemeniz gereken ücret 200 Euro.
                                    Ödemenizi gerçekleştirirken açıklama kısmında profilinizde yer alan müşteri numaranızı eklemeyi unutmayınız.
                                </div>
                            </c:when>
                            <c:when test="${user.appType eq 2}">
                                <div class="alert alert-info" role="alert">
                                    Lisans başvurunuzun işleme alınabilmesi için ödemeniz gereken ücret 200 Euro.
                                    Ödemenizi gerçekleştirirken açıklama kısmında profilinizde yer alan müşteri numaranızı eklemeyi unutmayınız.
                                </div>
                            </c:when>
                            <c:when test="${user.appType eq 3}">
                                <div class="alert alert-info" role="alert">
                                    Yüksek Lisans başvurunuzun işleme alınabilmesi için ödemeniz gereken ücret 300 Euro.
                                    Ödemenizi gerçekleştirirken açıklama kısmında profilinizde yer alan müşteri numaranızı eklemeyi unutmayınız.
                                </div>
                            </c:when>
                        </c:choose>
                    </c:when>
                </c:choose>
            </center>
            <div class="row">
                <div class="col-md-6">
                    <div class="container">
                        <div class="alert alert-secondary" role="alert">
                            <center>Ödeme Seçenekleri</center>
                        </div>
                        <div id="paypal-form" class="" style="padding:5px;border: 1px solid lightslategray;">
                            <p class="lead" style="text-align: center;">PAYPAL</p>
                            <c:choose>
                                <c:when test="${user.requestId eq 2}">
                                    <form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
                                        <input type="hidden" name="cmd" value="_s-xclick">
                                        <input type="hidden" name="hosted_button_id" value="DEM9PYGBTZMC8">
                                        <table>
                                            <tr><td><input type="hidden" name="on0" value="Enter your Customer ID"></td></tr><tr><td><input type="hidden" name="os0" maxlength="200" value="${user.userId}"></td></tr>
                                        </table>
                                        <center><input type="image" src="https://www.paypalobjects.com/en_US/DE/i/btn/btn_paynowCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!"></center>
                                        <img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
                                    </form>
                                </c:when>
                                <c:when test="${user.requestId eq 1}">
                                    <c:choose>
                                        <c:when test="${user.appType eq 1}">
                                            <form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
                                                <input type="hidden" name="cmd" value="_s-xclick">
                                                <input type="hidden" name="hosted_button_id" value="JFTX7NFJATYKL">
                                                <table>
                                                    <tr><td><input type="hidden" name="on0" value="Enter your Customer ID"></td></tr><tr><td><input type="hidden" name="os0" maxlength="200" value="${user.userId}"></td></tr>
                                                </table>
                                                <center>
                                                    <input type="image" src="https://www.paypalobjects.com/en_US/DE/i/btn/btn_paynowCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
                                                </center>
                                                <img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
                                            </form>
                                        </c:when>
                                        <c:when test="${user.appType eq 2}">
                                            <form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
                                                <input type="hidden" name="cmd" value="_s-xclick">
                                                <input type="hidden" name="hosted_button_id" value="SXTQGTFUFZ3YG">
                                                <table>
                                                    <tr><td><input type="hidden" name="on0" value="Enter your Customer ID"></td></tr><tr><td><input type="hidden" name="os0" maxlength="200" value="${user.userId}"></td></tr>
                                                </table>
                                                <center><input type="image" src="https://www.paypalobjects.com/en_US/DE/i/btn/btn_paynowCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!"></center>
                                                <img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
                                            </form>
                                        </c:when>
                                        <c:when test="${user.appType eq 3}">
                                            <form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
                                                <input type="hidden" name="cmd" value="_s-xclick">
                                                <input type="hidden" name="hosted_button_id" value="ZA7X6DJSJ3C5Q">
                                                <table>
                                                    <tr><td><input type="hidden" name="on0" value="Enter your Customer ID"></td></tr><tr><td><input type="hidden" name="os0" maxlength="200" value="${user.userId}"></td></tr>
                                                </table>
                                                <center><input type="image" src="https://www.paypalobjects.com/en_US/DE/i/btn/btn_paynowCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!"></center>
                                                <img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
                                            </form>
                                        </c:when>
                                    </c:choose>
                                </c:when>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <div class="col-md-1">
                </div>
                <div class="col-md-5">
                    <div class="container" style="padding: 0; border: 1px solid lightslategray;">
                        <div class="alert alert-secondary" role="alert">
                            <center>Sepet Özeti</center>
                        </div>
                        <div class="container">
                            <div class="row">
                                <div class="col-md-5">
                                    İstek
                                </div>
                                <div class="col-md-2"></div>
                                <div class="col-md-5">
                                    <c:choose>
                                        <c:when test="${user.requestId eq 2}">
                                            İnceleme
                                        </c:when>
                                        <c:when test="${user.requestId eq 1}">
                                            Başvuru
                                        </c:when>
                                    </c:choose>
                                </div>
                            </div><hr>
                            <div class="row">
                                <div class="col-md-5">
                                    Başvuru Alanı
                                </div>
                                <div class="col-md-2"></div>
                                <div class="col-md-5">
                                    <c:choose>
                                        <c:when test="${user.appType eq 1}">
                                            Studienkolleg
                                        </c:when>
                                        <c:when test="${user.appType eq 2}">
                                            Lisans
                                        </c:when>
                                        <c:when test="${user.appType eq 3}">
                                            Yüksek Lisans
                                        </c:when>
                                    </c:choose>
                                </div>
                            </div><hr>
                            <div class="row">
                                <div class="col-md-5">
                                    Fiyat
                                </div>
                                <div class="col-md-2"></div>
                                <div class="col-md-5">
                                    <b><c:choose>
                                        <c:when test="${user.requestId eq 2}">
                                            30 Euro
                                        </c:when>
                                        <c:when test="${user.requestId eq 1}">
                                            <c:choose>
                                                <c:when test="${user.appType eq 1}">
                                                    200 Euro
                                                </c:when>
                                                <c:when test="${user.appType eq 2}">
                                                    200 Euro
                                                </c:when>
                                                <c:when test="${user.appType eq 3}">
                                                    300 Euro
                                                </c:when>
                                            </c:choose>
                                        </c:when>
                                    </c:choose></b>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="include/adsright.jsp"></jsp:include>
    </div>


</div>
<jsp:include page="include/footer.jsp"></jsp:include>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T"
        crossorigin="anonymous"></script>
</body>

</html>