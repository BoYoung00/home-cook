<%--
  Created by IntelliJ IDEA.
  User: qhdud
  Date: 2023-10-11
  Time: 오전 11:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h3>메인 페이지</h3>

    <%
        String userID = null;
        if (session.getAttribute("userID") != null) {
            userID = (String) session.getAttribute("userID");
        }
    %>

    <%
        if (userID == null) {
    %>
        <p>[로그아웃 상태]</p>
    <%
        } else {
    %>
        <p>[로그인 상태] <%=userID%>님, 어서오세요</p>
        <form action="Logout_action.jsp" method="post">
            <input type="submit" value="로그아웃">
        </form>
    <% } %>
</body>
</html>
