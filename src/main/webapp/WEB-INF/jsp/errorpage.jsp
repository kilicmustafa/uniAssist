<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: cemasma
  Date: 7/5/2018
  Time: 2:46 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Uni-Assistance | Error</title>
</head>
<body>
    <h3 class="display-3"><spring:message code="error.${errorCode}" /></h3>
</body>
</html>
