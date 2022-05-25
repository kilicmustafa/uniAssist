<%@ page import="com.uniassist.services.SessionData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

    <title>Uni-Assist - Dashboard</title>

    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />


    <!-- Bootstrap core CSS     -->
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Animation library for notifications   -->
    <link href="/resources/css/animate.min.css" rel="stylesheet"/>

    <!--  Light Bootstrap Table core CSS    -->
    <link href="/resources/css/light-bootstrap-dashboard.css?v=1.4.0" rel="stylesheet"/>


    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="/resources/css/demo.css" rel="stylesheet" />


    <!--     Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300' rel='stylesheet' type='text/css'>
    <link href="/resources/css/pe-icon-7-stroke.css" rel="stylesheet" />

</head>
<body>

<div class="wrapper">
    <jsp:include page="include/dashboardsidebar.jsp"></jsp:include>

    <div class="main-panel">
        <jsp:include page="include/dashboardnavbar.jsp"></jsp:include>


        <div class="content">
            <div class="row">
                <div class="col-md-1"></div>
                <div class="col-md-3">
                    <center>
                        <p class="lead"><spring:message code="onlinecountlead" /></p>
                        <h2>${count}</h2>
                        <p><spring:message code="onlinecountcontinue" /></p>
                    </center>
                </div>
                <div class="col-md-1"></div>
                <div class="col-md-6">
                    <center><p class="lead"><spring:message code="pageentercount" /></p></center>
                    <canvas id="myChart" width="400" height="400"></canvas>
                </div>
            </div>
            <div class="row" style="margin-top: 25px;">
                <div class="col-md-1"></div>
                <div class="col-md-3">

                    <center><p class="lead"><spring:message code="applydistrubition" /></p><canvas id="doughnut" width="400" height="400"></canvas></center>
                </div>
                <div class="col-md-1"></div>
                <div class="col-md-6">
                    <center><p class="lead"><spring:message code="registerdistrubition" /></p></center>
                    <canvas id="myLine" width="400" height="400"></canvas>
                </div>
            </div>
        </div>


        <jsp:include page="include/dashboardfooter.jsp" />

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

<!-- Light Bootstrap Table Core javascript and methods for Demo purpose -->
<script src="/resources/js/light-bootstrap-dashboard.js?v=1.4.0"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>
<style>
    #myChart {

        width:600px !important;
        height:300px !important;

    }

    #myLine {
        width:600px !important;
        height:300px !important;
    }

    #doughnut {
        widows: 275px !important;
        height: 300px !important;
    }
</style>
<script>

    var ctx = document.getElementById("myChart").getContext('2d');
    var pageCounter, myChart;
    $.getJSON( "/dashboard/analytics/pagecounter", function( data ) {
        pageCounter = data;
        myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ["index", "profile", "edit", "login", "register", "how-to-appy", "faq", "about"],
                datasets: [{
                    label: 'Page Analytics',
                    data: [pageCounter["index"], pageCounter["profile"], pageCounter["edit"], pageCounter["login"],
                        pageCounter["register"], pageCounter['how-to-apply'], pageCounter["faq"], pageCounter["about"]],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)',
                        'rgba(267, 90, 47, 0.2)',
                        'rgba(112, 50, 50, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255,99,132,1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)',
                        'rgba(267, 90, 47, 1)',
                        'rgba(112, 50, 50, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero:true
                        }
                    }]
                }
            }
        });
    });

    var ctx2 = document.getElementById("myLine").getContext('2d');
    var distrubiton, myLineChart;
    $.getJSON( "/dashboard/analytics/registrationdistrubition", function( data ) {
        distrubiton = data;
        myLineChart = new Chart(ctx2, {
            type: 'line',
            data: {
                labels: Object.keys(distrubiton),
                datasets: [{
                    label: 'Registration Distrubition',
                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
                    borderColor: 'rgba(255,99,132,1)',
                    data: Object.values(distrubiton),
                    fill: false
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero:true
                        }
                    }]
                }
            }
        });
    });

    var ctx3 = document.getElementById("doughnut").getContext('2d');
    var states, myDoughnut;
    $.getJSON( "/dashboard/analytics/applicationstatedistrubition", function( data ) {
        states = data;
        var color = [], keys = [];
        var dynamicColors = function() {
            var r = Math.floor(Math.random() * 255);
            var g = Math.floor(Math.random() * 255);
            var b = Math.floor(Math.random() * 255);
            return "rgb(" + r + "," + g + "," + b + ")";
        };
        for(var i in states) {
            color.push(dynamicColors());
            keys.push("Step " + i);
        }

        myDoughnut = new Chart(ctx3, {
            type: 'doughnut',
            data: {
                labels: keys,
                datasets: [{
                    backgroundColor: color,
                    data: Object.values(states)
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false
            }
        });
    });
</script>

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
