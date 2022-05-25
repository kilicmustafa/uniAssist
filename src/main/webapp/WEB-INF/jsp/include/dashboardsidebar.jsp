<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="sidebar" data-color="blue" data-image="/resources/images/b.jpg">

    <!--

        Tip 1: you can change the color of the sidebar using: data-color="blue | azure | green | orange | red | purple"
        Tip 2: you can also add an image using data-image tag

    -->

    <div class="sidebar-wrapper">
        <div class="logo">
            <a href="http://www.uni-assist.com" class="simple-text">
                Uni-Assist
            </a>
        </div>

        <ul class="nav">
            <li class="active">
                <a href="/dashboard">
                    <i class="pe-7s-graph"></i>
                    <p>Dashboard</p>
                </a>
            </li>
            <li>
                <a href="/dashboard/users/1">
                    <i class="pe-7s-user"></i>
                    <p><spring:message code="dashboard.sidebar.userlist" /></p>
                </a>
            </li>
            <!--<li>
                <a href="/dashboard/applications">
                    <i class="pe-7s-note2"></i>
                    <p>Application List</p>
                </a>
            </li>-->
            <li>
                <a href="/dashboard/trash">
                    <i class="pe-7s-trash"></i>
                    <p><spring:message code="dashboard.sidebar.trash" /></p>
                </a>
            </li>
            <li>
                <a href="/dashboard/agencies">
                    <i class="pe-7s-portfolio"></i>
                    <p><spring:message code="dashboard.sidebar.agencies" /></p>
                </a>
            </li>
            <li>
                <a href="/dashboard/formats">
                    <i class="pe-7s-note2"></i>
                    <p><spring:message code="dashboard.sidebar.formats" /></p>
                </a>
            </li>
            <c:if test="${sessionScope.get('role') eq 1}">
                <li>
                    <a href="/dashboard/addformats">
                        <i class="pe-7s-plus"></i>
                        <p><spring:message code="dashboard.sidebar.addformat" /></p>
                    </a>
                </li>
            </c:if>
            <li>
                <a href="/dashboard/analytics">
                    <i class="pe-7s-graph1"></i>
                    <p><spring:message code="dashboard.sidebar.analytics" /></p>
                </a>
            </li>
        </ul>
    </div>
</div>