<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach items="${labels}" var="label">
    <div class="applicationfile form-group row <c:forEach items='${label.types}' var='type'>${type} </c:forEach>">
        <label class="col-md-5" for="${label.name}">${label.name}</label>
        <input type="hidden" name="file-headline${labels.indexOf(label)}"
               value="${label.name}">
        <input type="file" class="form-control-file col-md-7" name="files"
               id="${label.name}"
               accept="application/pdf, image/*" data-parsley-max-file-size="1500"
               data-parsley-trigger="change">
    </div>
</c:forEach>