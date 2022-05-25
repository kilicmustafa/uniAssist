<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: cemasma
  Date: 6/21/2018
  Time: 4:11 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

    <title>Uni-Assist - Dashboard</title>

    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport'/>
    <meta name="viewport" content="width=device-width"/>


    <!-- Bootstrap core CSS     -->
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet"/>

    <!-- Animation library for notifications   -->
    <link href="/resources/css/animate.min.css" rel="stylesheet"/>

    <!--  Light Bootstrap Table core CSS    -->
    <link href="/resources/css/light-bootstrap-dashboard.css?v=1.4.0" rel="stylesheet"/>


    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="/resources/css/demo.css" rel="stylesheet"/>


    <!--     Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300' rel='stylesheet' type='text/css'>
    <link href="/resources/css/pe-icon-7-stroke.css" rel="stylesheet"/>

    <script>
        var stage;
        window.onload = function () {
            stage = document.getElementById("stage3");
            if (document.getElementById("appType1").checked) {
                document.getElementById("stage3").remove();
            }
        }

        function handleChange() {
            if (document.getElementById("appType2").checked) {
                document.getElementById("applicationForm").appendChild(stage);
                stage.style.visibility = "visible";
            } else {
                stage.style.visibility = "hidden";
                document.getElementById("stage3").remove();
            }
        }

        function sendApplicationForm() {

            var isItOk = true;
            var allowedByte = 1572864;
            if (document.getElementById("firstName") !== null) {
                if (document.getElementById("firstName").value.length > 15) {
                    isItOk = false;
                    alert("İsim bilginiz en fazla 15 karakterden oluşabilir.");
                } else if (document.getElementById("lastName").value.length > 15) {
                    isItOk = false;
                    alert("Soyadı bilginiz en fazla 15 karakterden oluşabilir.");
                } else if (document.getElementById("inputPassword").value !== "" || document.getElementById("passwordAgain").value !== "") {
                    if (document.getElementById("inputPassword").value !== document.getElementById("passwordAgain").value) {
                        isItOk = false;
                        alert("Girdiğiniz şifreler aynı değil.");
                    } else if (document.getElementById("inputPassword").value.length < 8 || document.getElementById("inputPassword").value.length > 12) {
                        isItOk = false;
                        alert("Şifre bilginiz en fazla 12, en az 8 karakterden oluşmalıdır.");
                    }
                }
            }
            if (controlFileUpload("photo") === false) {
                alert("Dosya boyutu maximum 1.5 MB olmalıdır.");
                isItOk = false;
            } else if (controlFileUpload("osymSonuc") === false) {
                alert("Dosya boyutu maximum 1.5 MB olmalıdır.");
                isItOk = false;
            } else if (controlFileUpload("osymYerlesim") === false) {
                alert("Dosya boyutu maximum 1.5 MB olmalıdır.");
                isItOk = false;
            } else if (controlFileUpload("liseDiploma") === false) {
                alert("Dosya boyutu maximum 1.5 MB olmalıdır.");
                isItOk = false;
            } else if (controlFileUpload("liseTranskript") === false) {
                alert("Dosya boyutu maximum 1.5 MB olmalıdır.");
                isItOk = false;
            } else if (document.getElementById("appType2").checked) {
                if (controlFileUpload("universiteDiploma") === false) {
                    isItOk = false;
                    alert("Dosya boyutu maximum 1.5 MB olmalıdır.");
                } else if (controlFileUpload("universiteTranskript") === false) {
                    isItOk = false;
                    alert("Dosya boyutu maximum 1.5 MB olmalıdır.");
                }
            }

            function controlFileUpload(id) {
                if (document.getElementById(id).files.length === 0) {
                    return true;
                } else if (document.getElementById(id).files[0].size > allowedByte) {
                    return false;
                }
            }

            if (isItOk) {
                var form = $('#applicationForm')[0];

                var data = new FormData(form);
                $.ajax({
                    type: "POST",
                    enctype: 'multipart/form-data',
                    url: "/profile",
                    data: data,
                    processData: false,
                    contentType: false,
                    cache: false,
                    timeout: 600000,
                    success: function (data) {
                        alert("Başvuru alındı.")
                    },
                    error: function (e) {

                        alert("Başvuru alınamadı.")
                    }
                });
            }
        }
    </script>
</head>
<body>

<div class="wrapper">
    <jsp:include page="include/dashboardsidebar.jsp"></jsp:include>

    <div class="main-panel">
        <jsp:include page="include/dashboardnavbar.jsp"></jsp:include>


        <div class="content">
            <div class="container-fluid">
                <p class="lead">${user.firstName} ${user.lastName} isimli kullanıcı için başvuru ayarları</p>
                <form class="form-horizontal" id="applicationForm" enctype="multipart/form-data">
                    <input type="hidden" name="userId" value="${userId}">
                    <input type="hidden" name="dashboard" value="true">
                    <div class="form-group">
                        <label class="col-3">İsteğiniz: </label>
                        <label class="radio-inline">
                            <input type="radio" name="requestId" value="1" id="requestId1" autocomplete="off"
                                   <c:if test="${user.requestId eq 1}">checked</c:if> > Başvuru
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="requestId" value="2" id="requestId2" autocomplete="off"
                                   <c:if test="${user.requestId eq 2}">checked</c:if>> İnceleme
                        </label>
                    </div>

                    <div class="form-group">
                        <label class="col-3">Başvuru Alanınız: </label>
                        <label class="radio-inline">
                            <input type="radio" name="appType" value="1" id="appType1" onchange="handleChange();"
                                   autocomplete="off"
                                   <c:if test="${user.appType eq 1}">checked</c:if>> Lisans
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="appType" value="2" id="appType2" onchange="handleChange();"
                                   autocomplete="off"
                                   <c:if test="${user.appType eq 2}">checked</c:if>> Yüksek Lisans
                        </label>
                    </div>
                    <div id="stage2">
                        <div class="form-group">
                            <label for="photo">Fotoğrafınızı yükleyiniz</label>
                            <input type="file" class="form-control-file" id="photo" name="photo" accept="image/*">
                        </div>
                        <div class="form-group">
                            <label for="osymSonuc">ÖSYM sonucunuzu içeren dosyayı yükleyiniz</label>
                            <input type="file" class="form-control-file" id="osymSonuc" name="osymSonuc"
                                   accept="application/pdf, image/*">
                        </div>
                        <div class="form-group">
                            <label for="osymYerlesim">ÖSYM Yerleşim sonucunuzu içeren dosyayı yükleyiniz</label>
                            <input type="file" class="form-control-file" id="osymYerlesim" name="osymYerlesim"
                                   accept="application/pdf, image/*">
                        </div>
                        <div class="form-group">
                            <label for="liseDiploma">Lise diplomanızı içeren dosyayı yükleyiniz</label>
                            <input type="file" class="form-control-file" id="liseDiploma" name="liseDiploma"
                                   accept="application/pdf, image/*">
                        </div>
                        <div class="form-group">
                            <label for="liseTranskript">Lise transkriptinizi içeren dosyayı yükleyiniz</label>
                            <input type="file" class="form-control-file" id="liseTranskript" name="liseTranskript"
                                   accept="application/pdf, image/*">
                        </div>
                        <div id="stage3">
                            <div class="form-group">
                                <label for="universiteDiploma">Üniversite diplomanızı içeren dosyayı yükleyiniz</label>
                                <input type="file" class="form-control-file" id="universiteDiploma"
                                       name="universiteDiploma"
                                       accept="application/pdf, image/*">
                            </div>
                            <div class="form-group">
                                <label for="universiteTranskript">Üniversite transkriptinizi içeren dosyayı
                                    yükleyiniz</label>
                                <input type="file" class="form-control-file" id="universiteTranskript"
                                       name="universiteTranskript" accept="application/pdf, image/*">
                            </div>
                        </div>
                    </div>
                </form>
                <div class="row">
                    <!--<div class="col-sm-6">
                        <button id="preStage" onclick="changeStage(-1)" class="btn btn-primary disabled">Önceki</button>
                    </div>-->
                    <div class="col-sm-12">
                        <button id="nextStage" onclick="sendApplicationForm()" class="btn btn-primary">Gönder</button>
                    </div>
                </div>
            </div>
        </div>


        <jsp:include page="include/dashboardfooter.jsp"/>

    </div>
</div>


</body>

<!--   Core JS Files   -->
<script src="/resources/js/jquery.3.2.1.min.js" type="text/javascript"></script>
<script src="/resources/js/bootstrap.min.js" type="text/javascript"></script>

<!--  Charts Plugin -->
<script src="/resources/js/chartist.min.js"></script>

<!--  Notifications Plugin    -->
<script src="/resources/js/bootstrap-notify.js"></script>

<!--  Google Maps Plugin    -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>

<!-- Light Bootstrap Table Core javascript and methods for Demo purpose -->
<script src="/resources/js/light-bootstrap-dashboard.js?v=1.4.0"></script>

<!-- Light Bootstrap Table DEMO methods, don't include it in your project! -->
<script src="/resources/js/demo.js"></script>

<!--
<script type="text/javascript">
    $(document).ready(function(){

        demo.initChartist();

        $.notify({
            icon: 'pe-7s-gift',
            message: "Welcome to <b>Light Bootstrap Dashboard</b> - a beautiful freebie for every web developer."

        },{
            type: 'info',
            timer: 4000
        });

    });
</script>
-->

</html>
