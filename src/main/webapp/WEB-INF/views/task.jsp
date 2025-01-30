<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<h1>Tasks</h1>
<div>
</div>
<table>
    <th>
        <td>Title</td>
        <td>Description</td>
    </th>
    <c:forEach items="${tasks}" var="task">
    <tr>
        <td>${task.title}</td>
        <td>${task.description}</td>
    </tr>
    </c:forEach>
</table>





