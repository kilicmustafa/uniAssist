<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<footer class="footer">
    <div class="container-fluid">
        <nav class="pull-left">
            <ul>
                <li>
                    <a href="/">
                        <spring:message code="dashboard.footer.home"/>
                    </a>
                </li>
                <li>
                    <a href="/about">
                        <spring:message code="dashboard.footer.about"/>
                    </a>
                </li>
                <li>
                    <a href="/how-to-apply">
                        <spring:message code="footer.howtoapply"/>
                    </a>
                </li>
            </ul>
        </nav>
        <p class="copyright pull-right">
            © 2018 - Uni-Assist, All rights reserved
        </p>
    </div>
</footer>