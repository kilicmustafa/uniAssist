<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!-- Footer -->
<footer class="page-footer font-small blue pt-4 mt-4" style="border-top: solid 1px black;">

    <!-- Footer Links -->
    <div class="container-fluid text-center">

        <!-- Grid row -->
        <div class="row">

            <!-- Grid column -->
            <div class="col-md-6 mt-md-0 mt-3">

                <!-- Content -->
                <h5 class="text-uppercase"><spring:message code="footer.contact" /></h5>
                <ul class="list-inline">
                    <li class="list-inline-item fas fa-phone"></li>
                    <li class="list-inline-item">+49/(0)201 10 26 731</li>
                </ul>
                <ul class="list-inline">
                    <li class="list-inline-item fas fa-envelope"></li>
                    <li class="list-inline-item">info@uni-assist.com</li>
                </ul>

            </div>
            <!-- Grid column -->

            <hr class="clearfix w-100 d-md-none pb-3">

            <!-- Grid column -->
            <div class="col-md-6 mb-md-0 mb-3">

                <!-- Links -->
                <h5 class="text-uppercase"><spring:message code="footer.links" /></h5>

                <ul class="list-unstyled">
                    <li>
                        <a href="/"><spring:message code="navbar.home" /></a>
                    </li>
                    <li>
                        <a href="/faq"><spring:message code="navbar.faq" /></a>
                    </li>
                    <li>
                        <a href="/how-to-apply"><spring:message code="footer.howtoapply" /></a>
                    </li>
                    <li>
                        <a href="/about"><spring:message code="navbar.about" /></a>
                    </li>
                </ul>

            </div>
            <!-- Grid column -->

        </div>
        <!-- Grid row -->

    </div>
    <!-- Footer Links -->

    <!-- Copyright -->
    <div class="footer-copyright text-center py-3" style="box-shadow: 0px 0px 2px 0px grey;">© 2018 -
        <a href="http://uni-assist.com/"> Uni-Assistance, All rights reserved</a>
    </div>
    <!-- Copyright -->

</footer>
<!-- Footer -->