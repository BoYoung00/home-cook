<%--
  Created by IntelliJ IDEA.
  User: qhdud
  Date: 2023-10-11
  Time: 오전 11:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <%
        session.invalidate();
    %>
    <script>
        location.href = '../Main.jsp';
    </script>
</body>
</html>
