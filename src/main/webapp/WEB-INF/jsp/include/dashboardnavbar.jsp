<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-default navbar-fixed">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navigation-example-2">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/dashboard">Dashboard</a>
        </div>
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-left">
                <li>
                    <a href="/dashboard/adduser">
                        <p><spring:message code="dashboard.nav.adduser" /></p>
                    </a>
                </li>
                <c:if test="${sessionScope.get('role') eq 1}">
                    <li>
                        <a href="/dashboard/addagency">
                            <p><spring:message code="dashboard.nav.addagency" /></p>
                        </a>
                    </li>
                </c:if>
            </ul>
            <ul class="col-md-6 nav navbar-nav navbar-left">
                <li class="col-md-12">
                    <form action="/dashboard/search/" method="post" style="margin-top:8px;">
                        <input class="form-control" name="searchText" placeholder="Search with ID, Email, Name" type="search" placeholder="Search" aria-label="Search">
                    </form>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="/profile">
                        <p><spring:message code="dashboard.nav.profile" /></p>
                    </a>
                </li>
                <li>
                    <a href="/exit">
                        <p><spring:message code="dashboard.nav.exit" /></p>
                    </a>
                </li>
                <li class="separator hidden-lg"></li>
            </ul>
        </div>
    </div>
</nav>

<c:if test="${notFound} eq 'true'">
    <script>
        alert("User not found.");
    </script>
</c:if>