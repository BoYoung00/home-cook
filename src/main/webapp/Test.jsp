<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--
  Created by IntelliJ IDEA.
  User: Bo
  Date: 2023-10-22
  Time: 오후 11:58
  To change this template use File | Settings | File Templates.
--%>

<%
    // 서버에서 저장할 localhost 뒤에 붙는 위치
    String path = "/upload/image";
    String realPath = request.getServletContext().getRealPath(path);
    System.out.println(realPath);

    // 저장 용량 제한
    int size = 10 * 1024 * 1024; //10M

    // 실제적 파일 업로드 처리
    MultipartRequest multi = new MultipartRequest(request, request.getParameter("imgFile"), size, "UTF-8", new DefaultFileRenamePolicy());
%>

<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>
